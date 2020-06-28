/************************************************************************/ 
/* This program is to run the two sample T-test to check whether there  */
/* is any statistical difference in CO2 emission between the year 2010  */ 
/* and 2011. The input data set file contains CO2 emission information  */  
/* of all countries from 1960 t0 2011 and program imports the input     */
/* data file which is in excel format.                                  */                                              
/************************************************************************/ 
 
/* Import the excel input data file ‘World_Bank_CO2.xlsx’ from the path  */
/* /folders/myfolders/Data/World_Bank_CO2.xlsx                           */

PROC IMPORT DATAFILE="/folders/myfolders/Data/World_Bank_CO2.xlsx" 
    OUT=WORK.MYEXCEL /* name of the new table to import the data */
    DBMS=XLSX   /* type of the file XLSX */
    REPLACE;
    SHEET="CO2 (kt) Pivoted"; /* read only work sheet ‘CO2 (kt) Pivoted’ */

/* Create temporary data set WORK.MYEXCEL_V1 and write the filtered data*/ 
/* from the imported data set       */
DATA WORK.MYEXCEL_V1(KEEP=YEAR CO2_KT);  /* write only the variable YEAR and 
                                        CO2_KT */
SET WORK.MYEXCEL;    /* read the imported dataset WORK.MYEXCEL */
RENAME 'CO2__kt_'N=CO2_KT;  /* rename the variable to CO2_KT */
WHERE YEAR IN (2011,2010); /* filter only the data from year 2010 and 2011 */
  
/* Perfom the two sample T-test, in this test the null hypotheis is that there 
is no difference in the mean value of CO2 emission for the year 2010 and 2011 
so the HO=0 and the alternate hypothesis is that the mean value of CO2 is not 
equal for the year 2010 and 2011. We run the test at of significance level 
of 0.05, ALPHA=.05 */

PROC TTEST DATA=WORK.MYEXCEL_V1 HO=0 SIDES=2 ALPHA=.05;
CLASS YEAR; /* define the grouping variable ‘year’ */
VAR CO2_KT; /* Compare the means for the variable ‘CO2_KT’*/
RUN;

    
