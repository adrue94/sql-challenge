-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.


CREATE TABLE "Deparments" (
    "Dept_No" VARCHAR(255)   NOT NULL,
    "Dept_Name" VARCHAR(255)   NOT NULL,
    CONSTRAINT "pk_Deparments" PRIMARY KEY (
        "Dept_No"
     )
);

CREATE TABLE "Titles" (
    "Title_ID" VARCHAR(255)   NOT NULL,
    "Title" VARCHAR(255)   NOT NULL,
    CONSTRAINT "pk_Titles" PRIMARY KEY (
        "Title_ID"
     )
);

CREATE TABLE "Employees" (
    "Emp_no" INT   NOT NULL,
    "Emp_Title_ID" VARCHAR(255)   NOT NULL,
    "Birth_Date" VARCHAR(255)   NOT NULL,
    "First_Name" VARCHAR(255)   NOT NULL,
    "Last_Name" VARCHAR(255)   NOT NULL,
    "Sex" VARCHAR(255)   NOT NULL,
    "Hire_Date" VARCHAR(255)   NOT NULL,
    CONSTRAINT "pk_Employees" PRIMARY KEY (
        "Emp_no"
     )
);

CREATE TABLE "Dept_Emp" (
    "Emp_No" INT   NOT NULL,
    "Dept_No" VARCHAR(255)   NOT NULL
);

CREATE TABLE "Dept_Manager" (
    "Dept_No" VARCHAR(255)   NOT NULL,
    "Emp_No" INT   NOT NULL
);

CREATE TABLE "Salaries" (
    "Emp_No" INT   NOT NULL,
    "Salaries" INT   NOT NULL
);

ALTER TABLE "Employees" ADD CONSTRAINT "fk_Employees_Emp_Title_ID" FOREIGN KEY("Emp_Title_ID")
REFERENCES "Titles" ("Title_ID");

ALTER TABLE "Dept_Emp" ADD CONSTRAINT "fk_Dept_Emp_Emp_No" FOREIGN KEY("Emp_No")
REFERENCES "Employees" ("Emp_no");

ALTER TABLE "Dept_Emp" ADD CONSTRAINT "fk_Dept_Emp_Dept_No" FOREIGN KEY("Dept_No")
REFERENCES "Deparments" ("Dept_No");

ALTER TABLE "Dept_Manager" ADD CONSTRAINT "fk_Dept_Manager_Dept_No" FOREIGN KEY("Dept_No")
REFERENCES "Deparments" ("Dept_No");

ALTER TABLE "Dept_Manager" ADD CONSTRAINT "fk_Dept_Manager_Emp_No" FOREIGN KEY("Emp_No")
REFERENCES "Employees" ("Emp_no");

ALTER TABLE "Salaries" ADD CONSTRAINT "fk_Salaries_Emp_No" FOREIGN KEY("Emp_No")
REFERENCES "Employees" ("Emp_no");

