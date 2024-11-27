
/*
PROC IMPORT
	out=Housing_1_data
	datafile='/home/u64002639/4887_project/Project_Housing.csv'
	dbms=csv
	replace;
RUN;
*/

/* 1. Generate (Last 20 rows) processed renting post records. */
PROC SQL noprint;
	select count(*) into :nobs from Housing_1_data;
quit;

data post_this;
    set Housing_1_data;
    if _N_ >= &nobs - 19 and _N_ <= &nobs;
run;

/* 2.What kind of property is having the most number of the reception on average? */
PROC SQL;
	select PropertyType, mean(TotalReceptions) as AverageReceptions
    from Housing_1_data
    group by PropertyType
    order by AverageReceptions desc;
quit;

/* 3.What is the contribution of house type in the record? What is the most common type of property in the UK? */
PROC SGPLOT data=Housing_1_data;
    title "Property Type Distribution";
    vbar PropertyType / stat=freq;
RUN;

/* 4.What is the value distribution of the number of bathroom between the flat house and terraced house? */


/* 5.What kind of property is contain the second most turnover?*/
PROC SQL;
    select PropertyType, count(*) as Turnover
    from Housing_1_data
    group by PropertyType
    order by Turnover desc;
quit;

/* 6.Is there any relationship between the number of bedrooms, the number of bathrooms and the average price of a different property? */
PROC SQL;
    select TotalBeds, TotalBaths, mean(Price) as AveragePrice
    from Housing_1_data
    group by TotalBeds, TotalBaths
    order by TotalBeds, TotalBaths;
quit;



