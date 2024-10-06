SELECT *
FROM layoffs_raw;

-- 0. Create a staging table and Set 'NULL' to null
CREATE TABLE layoffs_staging LIKE layoffs_raw;

INSERT INTO layoffs_staging
SELECT *
FROM layoffs_raw;

UPDATE layoffs_staging
SET percentage_laid_off = NULL
WHERE percentage_laid_off = 'NULL';

-- 1. Remove Duplicates (De-duplicate?)
-- CTE to check for duplicates
WITH duplicate_cte AS (
    SELECT
        *,
        ROW_NUMBER() OVER(PARTITION BY
            company,
            location,
            industry,
            total_laid_off,
            percentage_laid_off,
            `date`,
            stage,
            country,
            funds_raised_millions
            ) AS row_num
    FROM layoffs_staging
)
SELECT *
FROM duplicate_cte
WHERE row_num > 1;

-- Create a table to remove duplicates
CREATE TABLE layoffs_staging2
(
    company               text NULL,
    location              text NULL,
    industry              text NULL,
    total_laid_off        int  NULL,
    percentage_laid_off   text NULL,
    `date`                  text NULL,
    stage                 text NULL,
    country               text NULL,
    funds_raised_millions int  NULL,
    row_num int  NULL
);

-- insert data with row_num
INSERT INTO layoffs_staging2
SELECT
    *,
    ROW_NUMBER() OVER(PARTITION BY
        company,
        location,
        industry,
        total_laid_off,
        percentage_laid_off,
        `date`,
        stage,
        country,
        funds_raised_millions
    ) AS row_num
FROM layoffs_staging;

-- delete every duplicates
DELETE
FROM layoffs_staging2
WHERE row_num > 1;

-- now there are bo results for this query
SELECT *
FROM layoffs_staging2
WHERE row_num > 1;

-- our data without duplicates
SELECT *
FROM layoffs_staging2;

-- 2. Standardize the Data

-- remove white spaces from company column
UPDATE layoffs_staging2
SET company = TRIM(company);

SELECT DISTINCT industry
FROM layoffs_staging2;

UPDATE layoffs_staging2
SET industry = 'Crypto'
WHERE industry LIKE "Crypto%";

SELECT DISTINCT country
FROM layoffs_staging2
ORDER BY 1;

-- remove trailing comma
UPDATE layoffs_staging2
SET country = TRIM(TRAILING '.' FROM country)
WHERE country LIKE "%.";

SELECT `date`
FROM layoffs_staging2
ORDER BY 1;

UPDATE layoffs_staging2
SET `date` = NULL
WHERE `date` = 'NULL';

-- format `date` to proper date string type
UPDATE layoffs_staging2
SET `date` = STR_TO_DATE(`date`, '%m/%d/%Y')
WHERE `date` IS NOT NULL;

ALTER TABLE layoffs_staging2
MODIFY COLUMN `date` DATE;

-- 3. Null Values or Blank Values
SELECT company, industry
FROM layoffs_staging2
WHERE industry IS NULL;

-- Fill null, 'NULL', and '' with values we have in another records
UPDATE layoffs_staging2
SET industry = NULL
WHERE industry = 'NULL';

SELECT t1.company, t1.industry, t2.industry
FROM layoffs_staging2 AS t1
JOIN layoffs_staging2 AS t2
    ON t1.company = t2.company
WHERE t1.industry IS NULL
    AND t2.industry IS NOT NULL;

UPDATE layoffs_staging2 AS t1
JOIN layoffs_staging2 AS t2
    ON t1.company = t2.company
SET t1.industry = t2.industry
WHERE t1.industry IS NULL
AND t2.industry IS NOT NULL;

-- 4. Remove Any Useless Columns or Rows
SELECT *
FROM layoffs_staging2;

ALTER TABLE layoffs_staging2
DROP COLUMN row_num;

-- those records are useless
SELECT *
FROM layoffs_staging2
WHERE total_laid_off IS NULL
  AND percentage_laid_off IS NULL;

-- let's delete them all
DELETE
FROM layoffs_staging2
WHERE total_laid_off IS NULL
  AND percentage_laid_off IS NULL;
