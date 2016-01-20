

library (XML)
library (httr)
scrapMobilePrices <- function(brand, totalPages) {
  company <- brand
  fileURL <-"mobile-phones/"
  company <- paste(company, "/?viewType=gridView&page=1", sep = "")
  fileURL <- paste(fileURL, company, sep = "")
  
  cafile <- system.file("CurlSSL", "cacert.pem", package = "RCurl")
  for (i in 1:totalPages) {
    if (i > 1) {
      fileURL <-"mobile-phones/"
      company <- paste(company, "/?viewType=gridView&page=", sep = "")
      company <- paste(company, i, sep = "")
      fileURL <- paste(fileURL, company, sep = "")
      print(fileURL)
    }
    page <- GET("https://www.daraz.pk/", path=fileURL, config(cainfo = cafile) )
    
    h <-  htmlParse(page)
    name <- xpathSApply(h, "//div[@class='sku -gallery']/a/h2/span[@class='name']", xmlValue)
    price <- xpathSApply(h, "//div[@class='sku -gallery']/a/span[@class='price-box']/span[@class='price ']/span[@dir='ltr']", xmlValue)
    
    dfrm <- data.frame(Name = name, Price = price)
    if (i == 1) {
      write.table(dfrm, file = paste(brand, "_phones.csv", sep = ""), sep = ",", row.names = FALSE)
    }
    else {
      write.table(dfrm, file = paste(brand, "_phones.csv", sep = ""), append = TRUE, sep = ",", row.names = FALSE, col.names=FALSE)
    }
  }
}
#For Blackberry-Phones
scrapMobilePrices("blackberry", 1)
#For Infinix-Phones
scrapMobilePrices("infinix", 1)
#For Mmobile-Phones
scrapMobilePrices("mmobile", 1)
#For Sony-Phones
scrapMobilePrices("sony", 1)
#For Ophone-Phones
scrapMobilePrices("ophone", 1)
#For Haier-Phones
scrapMobilePrices("haier", 1)
#For Lenovo-Phones
scrapMobilePrices("lenovo", 1)
#For Nokia-Phones
scrapMobilePrices("nokia", 1)
#For Gfive-Phones
scrapMobilePrices("gfive", 2)
#For Apple-Phones
scrapMobilePrices("apple", 2)
#For Rivo-Phones
scrapMobilePrices("rivo", 4)
#For Voice-Phones
scrapMobilePrices("voice", 3)
#For Microsoft-Phones
scrapMobilePrices("microsoft", 3)
#For Huawei-Phones
scrapMobilePrices("huawei", 4)
#For Samsung-Phones
scrapMobilePrices("samsung", 4)
#For Qmobile-Phones
scrapMobilePrices("qmobile", 6)

scrapTabletPrices <- function(brand, totalPages) {
  company <- brand
  fileURL <-"tablets/"
  company <- paste(company, "/?viewType=gridView&page=1", sep = "")
  fileURL <- paste(fileURL, company, sep = "")
  print(fileURL)
  cafile <- system.file("CurlSSL", "cacert.pem", package = "RCurl")
  for (i in 1:totalPages) {
    if (i > 1) {
      fileURL <-"tablets/"
      company <- paste(company, "/?viewType=gridView&page=", sep = "")
      company <- paste(company, i, sep = "")
      fileURL <- paste(fileURL, company, sep = "")
      
    }
    page <- GET("https://www.daraz.pk/", path=fileURL, config(cainfo = cafile) )
    
    h <-  htmlParse(page)
    name <- xpathSApply(h, "//div[@class='sku -gallery']/a/h2/span[@class='name']", xmlValue)
    price <- xpathSApply(h, "//div[@class='sku -gallery']/a/span[@class='price-box']/span[@class='price ']/span[@dir='ltr']", xmlValue)
    
    dfrm <- data.frame(Name = name, Price = price)
    if (i == 1) {
      write.table(dfrm, file = paste(brand, "_tablets.csv", sep = ""), sep = ",", row.names = FALSE)
    }
    else {
      write.table(dfrm, file = paste(brand, "_tablets.csv", sep = ""), append = TRUE, sep = ",", row.names = FALSE, col.names=FALSE)
    }
  }
}

scrapTabletPrices("apple", 1)

scrapTabletPrices("huawei", 1)

scrapTabletPrices("qmobile", 1)

scrapTabletPrices("microsoft", 1)

scrapTabletPrices("xpod", 1)

scrapTabletPrices("samsung", 1)

scrapTabletPrices("dany", 1)

scrapTabletPrices("evo", 1)

scrapTabletPrices("alphatronix", 1)

scrapTabletPrices("nvc", 1)

scrapTabletPrices("lenovo", 1)