use AdventureWorks2014;
-- Ranked order of Vendors by purchase amount $

Select distinct v.name as 'Vendor Name',sum(totaldue) as 'Total Amount' from AdventureWorks2014.Purchasing.Vendor as v
inner join AdventureWorks2014.Purchasing.ProductVendor as pv 
on v.BusinessEntityID=pv.BusinessEntityID
inner join AdventureWorks2014.Purchasing.PurchaseOrderDetail as pod
on pv.ProductID= pod.ProductID
inner join AdventureWorks2014.Purchasing.PurchaseOrderHeader as poh
on pod.PurchaseOrderID = poh.PurchaseOrderID
group by v.Name
order by [Total Amount] desc;

-- Ranked order of products purchased by amount $
-- By category
Select distinct p.name as 'Product Name',pc.name as 'Category Name',sum(totaldue) as 'Total Amount' from AdventureWorks2014.Production.ProductCategory as pc
inner join AdventureWorks2014.Production.ProductSubcategory as psc
on pc.ProductCategoryID=psc.ProductCategoryID
inner join AdventureWorks2014.Production.Product as p
on p.ProductSubcategoryID=psc.ProductSubcategoryID
inner join AdventureWorks2014.Purchasing.PurchaseOrderDetail as pod
on p.ProductID= pod.ProductID
inner join AdventureWorks2014.Purchasing.PurchaseOrderHeader as poh
on pod.PurchaseOrderID = poh.PurchaseOrderID
group by p.Name,pc.Name
order by [Total Amount] desc;

Select sum(Totaldue) from Purchasing.PurchaseOrderHeader;
-- By subcategory
Select p.name as 'Product Name',psc.name as 'Sub Category Name',sum(totaldue) as 'Total Amount' from AdventureWorks2014.Production.ProductSubcategory as psc
inner join AdventureWorks2014.Production.Product as p
on p.ProductSubcategoryID=psc.ProductSubcategoryID
inner join AdventureWorks2014.Purchasing.PurchaseOrderDetail as pod
on p.ProductID= pod.ProductID
inner join AdventureWorks2014.Purchasing.PurchaseOrderHeader as poh
on pod.PurchaseOrderID = poh.PurchaseOrderID
group by p.Name,psc.Name
order by [Total Amount] desc;


-- By product model (top 20)
Select distinct top 20 pm.name as 'Model Name',sum(totaldue) as 'Total Amount' from AdventureWorks2014.Production.ProductModel as pm
inner join AdventureWorks2014.Production.Product as p
on p.ProductModelID=pm.ProductModelID
inner join AdventureWorks2014.Purchasing.PurchaseOrderDetail as pod
on p.ProductID= pod.ProductID
inner join AdventureWorks2014.Purchasing.PurchaseOrderHeader as poh
on pod.PurchaseOrderID = poh.PurchaseOrderID
group by pm.Name
order by [Total Amount] desc;


-- By product (top 20)
Select distinct top 20 p.name as 'Product Name',sum(totaldue) as 'Total Amount' from  AdventureWorks2014.Production.Product as p
inner join AdventureWorks2014.Purchasing.PurchaseOrderDetail as pod
on p.ProductID= pod.ProductID
inner join AdventureWorks2014.Purchasing.PurchaseOrderHeader as poh
on pod.PurchaseOrderID = poh.PurchaseOrderID
group by p.Name
order by [Total Amount] desc;

-- List of employees who purchased products with phone, email & address
Select distinct concat(pe.FirstName,' ',pe.LastName) as 'Employee Name',concat(ad.AddressLine1,' ',ad.AddressLine2,' ',ad.City,' ',ad.PostalCode) as 'Address',pp.PhoneNumber,ea.EmailAddress ,sum(totaldue) as 'Total Amount' from Purchasing.PurchaseOrderDetail as pod
inner join Purchasing.PurchaseOrderHeader as poh
on poh.PurchaseOrderID=pod.PurchaseOrderID
inner join Person.Person as pe
on pe.BusinessEntityID= poh.EmployeeID
inner join HumanResources.Employee as e
on pe.BusinessEntityID=e.BusinessEntityID
inner join Person.PersonPhone as pp
on pp.BusinessEntityID=pe.BusinessEntityID
inner join Person.EmailAddress as ea
on ea.BusinessEntityID=pe.BusinessEntityID
inner join Person.BusinessEntity as be
on pe.BusinessEntityID=be.BusinessEntityID
inner join Person.BusinessEntityAddress as bea
on bea.BusinessEntityID=be.BusinessEntityID
inner join Person.Address as ad
on bea.AddressID=ad.AddressID
group by concat(pe.FirstName,' ',pe.LastName),concat(ad.AddressLine1,' ',ad.AddressLine2,' ',ad.City,' ',ad.PostalCode),pp.PhoneNumber,ea.EmailAddress
order by [Total Amount]desc;

-- List of employees who purchased products with pay rate & raises (SCD)
Select distinct concat(pe.FirstName,' ',pe.LastName) as 'Employee Name',eph.Rate,eph.RateChangeDate ,sum(totaldue) as 'Total Amount' from Purchasing.PurchaseOrderDetail as pod
inner join Purchasing.PurchaseOrderHeader as poh
on poh.PurchaseOrderID=pod.PurchaseOrderID
inner join Person.Person as pe
on pe.BusinessEntityID= poh.EmployeeID
inner join HumanResources.Employee as e
on pe.BusinessEntityID=e.BusinessEntityID
inner join Person.PersonPhone as pp
on pp.BusinessEntityID=pe.BusinessEntityID
inner join Person.EmailAddress as ea
on ea.BusinessEntityID=pe.BusinessEntityID
inner join Person.BusinessEntity as be
on pe.BusinessEntityID=be.BusinessEntityID
inner join Person.BusinessEntityAddress as bea
on bea.BusinessEntityID=be.BusinessEntityID
inner join Person.Address as ad
on bea.AddressID=ad.AddressID
inner join HumanResources.EmployeePayHistory as eph
on e.BusinessEntityID=eph.BusinessEntityID
group by concat(pe.FirstName,' ',pe.LastName),eph.Rate,eph.RateChangeDate
order by [Total Amount]desc;

-- List of purchasing vendor contacts with vendor name, phone, email & address

select v. BusinessEntityID as 'Vendor ID',v.Name as 'Vendor Name' ,pp.PhoneNumber,ea.EmailAddress,concat(ad.AddressLine1,' ',ad.AddressLine2,' ',ad.City,',',ad.PostalCode,',',sp.Name,',',cr.Name) as 'Address',sum(totaldue) as 'Total Amount' from Purchasing.Vendor as v
inner join AdventureWorks2014.Person.BusinessEntity as be
on be.BusinessEntityID=v.BusinessEntityID
inner join Person.BusinessEntityAddress as bea
on bea.BusinessEntityID= be.BusinessEntityID
inner join Person.Address as ad
on ad.AddressID = bea.AddressID 
inner join Person.BusinessEntityContact as pec
on pec.BusinessEntityID=be.BusinessEntityID
inner join Person.Person as pe
on pe.BusinessEntityID= pec.PersonID
inner join Person.PersonPhone as pp
on pe.BusinessEntityID=pp.BusinessEntityID
inner join Person.EmailAddress as ea 
on ea.BusinessEntityID=pe.BusinessEntityID
inner join Person.StateProvince as sp
on sp.StateProvinceID=ad.StateProvinceID
inner join Person.CountryRegion as cr
on cr.CountryRegionCode=sp.CountryRegionCode
inner join Purchasing.PurchaseOrderHeader as poh
on poh.VendorID= v.BusinessEntityID
group by v. BusinessEntityID,v.Name,pp.PhoneNumber,ea.EmailAddress,concat(ad.AddressLine1,' ',ad.AddressLine2,' ',ad.City,',',ad.PostalCode,',',sp.Name,',',cr.Name)
order by [Total Amount]desc;

-- List of product prices by product order by product and SCD effective ascending

Select p.Name as 'Product Name',plph.StartDate,plph.ModifiedDate,plph.EndDate,plph.ListPrice from Production.Product as p 
inner join Production.ProductListPriceHistory as plph
on plph.ProductID = p.ProductID
group by p.Name,plph.StartDate,plph.ModifiedDate,plph.EndDate,plph.ListPrice
order by p.Name;

-- List of standard costs by product order by product and SCD effective ascending
Select p.Name as 'Product Name',pch.StartDate,pch.ModifiedDate,pch.EndDate,pch.StandardCost from Production.Product as p 
inner join Production.ProductCostHistory as pch
on pch.ProductID = p.ProductID
group by p.Name,pch.StartDate,pch.ModifiedDate,pch.EndDate,pch.StandardCost
order by p.Name;

