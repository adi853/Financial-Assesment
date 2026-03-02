-- Creating Database --
create database financial_risk_assesment;
use financial_risk_assesment;
SELECT 
    *
FROM
    data;

-- 1. age wise loan ratio --
select 
		case when `Age`<25 then 'early age'	
			when `Age` between 25 and 50 then 'mid-aged'
				else 'old aged' 
end as age_status,
			concat(sum(`Loan Amount`),'$')as total_loan_amount,
				concat(round(sum(`Loan Amount`)*100.0/sum(sum(`Loan Amount`))over(),2),'%') as loan_ratio_percentage
from data
		group by age_status;

-- 2.INCOME WISE LOAN AMOUNT AND DTI RATIO --
SELECT*FROM data;
SELECT 
    `Income`,
		`Loan Amount`,
    CONCAT(ROUND(`Debt-to-Income Ratio` * 100.0, 2),
            '%') AS dti_ratio,
    CASE
        WHEN
            CONCAT(ROUND(`Debt-to-Income Ratio` * 100.0, 2),
                    '%') <= 30
        THEN
            'Approved'
        WHEN
            CONCAT(ROUND(`Debt-to-Income Ratio` * 100.0, 2),
                    '%') BETWEEN 30 AND 50
        THEN
            'Manual Review'
        ELSE 'rejected'
    END approval_status
FROM
    data;


-- 3.Credit Score,Income,loan amount,Payment History,& Asset Value --
SELECT 
    `Income`,
    `Loan Amount`,
    `Assets Value`,
    CASE
        WHEN
            `Credit Score` > 750
                AND `Payment History` = 'Excellent'
                AND `Assets Value` > 150000
                AND `Income`>70000
        THEN
            'Low Risk'
        WHEN
            `Credit Score` > 650
                AND `Payment History` = 'Good'
                AND `Assets Value` > 100000
                AND `Income`>45000
        THEN
            'mid-risk'
        ELSE 'High risk'
    END AS risk_status
FROM
    data;

-- 4.Previous Default And Investigation --
SELECT 
    `Loan Amount`,
    `Previous Defaults`,
    CASE
        WHEN `Previous Defaults` = 4 THEN 'High - Risk'
        WHEN `Previous Defaults` BETWEEN 2 AND 3 THEN 'Mid-risk'
        ELSE 'low risk'
    END AS risk_stattus
FROM
    data;