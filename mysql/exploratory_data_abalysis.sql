-- Top laid off and top percentage laid off
SELECT
    MAX(total_laid_off) AS top_laid_off,
    CONCAT(MAX(percentage_laid_off) * 100, '%') AS top_percentage_laid_off
FROM layoffs_staging2;

-- 100% laid off by funds raised
SELECT *
FROM layoffs_staging2
WHERE percentage_laid_off = 1
ORDER BY funds_raised_millions DESC;

-- Total laid off by company
SELECT
    company,
    SUM(total_laid_off) AS total
FROM layoffs_staging2
GROUP BY company
ORDER BY 2 DESC;

-- Period
SELECT
    MIN(`date`) AS start,
    MAX(`date`) AS end
FROM layoffs_staging2;

-- Total laid off by industry
SELECT
    industry,
    SUM(total_laid_off) AS total
FROM layoffs_staging2
WHERE industry IS NOT NULL
GROUP BY industry
ORDER BY 2 DESC;

-- Total laid off by country
SELECT
    country,
    SUM(total_laid_off) AS total
FROM layoffs_staging2
WHERE total_laid_off IS NOT NULL
GROUP BY country
ORDER BY 2 DESC;

-- Total laid off by year
SELECT
    YEAR(`date`) AS year,
    SUM(total_laid_off) AS total
FROM layoffs_staging2
WHERE `date` IS NOT NULL
GROUP BY YEAR(`date`)
ORDER BY 1 DESC;

-- Total laid off by stage
SELECT
    stage,
    SUM(total_laid_off) AS total
FROM layoffs_staging2
GROUP BY stage
ORDER BY 2 DESC;

-- Total laid off by year-month
SELECT
    SUBSTRING(`date`, 1, 7) AS `year_month`,
    SUM(total_laid_off) AS total
FROM layoffs_staging2
WHERE SUBSTRING(`date`, 1, 7) IS NOT NULL
GROUP BY `year_month`
ORDER BY 1;

-- Rolling total laid off by year-month
WITH rolling_total_laid_off AS (
    SELECT
        SUBSTRING(`date`, 1, 7) AS `year_month`,
        SUM(total_laid_off) AS total
    FROM layoffs_staging2
    WHERE SUBSTRING(`date`, 1, 7) IS NOT NULL
    GROUP BY `year_month`
    ORDER BY 1
)
SELECT
    `year_month`,
    total,
    SUM(total) OVER (ORDER BY `year_month`) AS rolling_total
FROM rolling_total_laid_off;

-- Total laid off by company by year
SELECT
    company,
    YEAR(`date`) AS year,
    SUM(total_laid_off) AS total
FROM layoffs_staging2
GROUP BY company, YEAR(`date`)
ORDER BY 3 DESC;

-- Top 5 layoffs by company by year
WITH company_year (company, year, total_laid_off) AS (
    SELECT
        company,
        YEAR(`date`),
        SUM(total_laid_off)
    FROM layoffs_staging2
    GROUP BY company, YEAR(`date`)
), company_year_rank AS (
    SELECT *,
        DENSE_RANK() OVER (
            PARTITION BY year
            ORDER BY total_laid_off DESC
        ) AS ranking
    FROM company_year
    WHERE year IS NOT NULL
)
SELECT *
FROM company_year_rank
WHERE ranking <= 5;