
[![AppVeyor Build Status](https://ci.appveyor.com/api/projects/status/github/rte-antares-rpackage/antaresDev?branch=master&svg=true)](https://ci.appveyor.com/project/rte-antares-rpackage/antaresDev)[![Travis-CI Build Status](https://travis-ci.org/rte-antares-rpackage/antaresDev.svg?branch=master)](https://travis-ci.org/rte-antares-rpackage/antaresDev)[![Coverage Status](https://img.shields.io/codecov/c/github/rte-antares-rpackage/antaresDev/master.svg)](https://codecov.io/github/rte-antares-rpackage/antaresDev?branch=master)



# antares-rpackageUtils

# fixing CRLF conversion

Like explain [here](https://github.com/krlmlr/r-appveyor), use a .gitattributes file that takes care of fixing CRLF conversion settings that are relevant on Windows. [The one in this repo](/.gitattributes) can be used for starters.

# Check your package with r-hub 

with R / RStudio, see : https://github.com/r-hub/rhub with this command 

```R
check_for_cran()
```

or directly with a website : https://builder.r-hub.io/

If you have some error like this 

```R
check_for_cran()
Error in curl::curl_fetch_memory(url, handle = handle) : 
  error setting certificate verify locations:
  CAfile: /mingw64/ssl/certs/ca-bundle.crt
  CApath: none
  
```

You must set your proxy 

 ```R
#by example ....
Sys.setenv(http_proxy="http://IP_PROXY:PORT_PROXY")
Sys.setenv(https_proxy="http://IP_PROXY:PORT_PROXY"

#check your parameter 
Sys.getenv("http_proxy")
Sys.getenv("https_proxy")

#For rte
 
Sys.setenv(http_proxy="http://NNI:Mdp@IP_PROXY:PORT_PROXY")
Sys.setenv(https_proxy="http://NNI:Mdp@IP_PROXY:PORT_PROXY")

 
 ```

# Naming convention in antaresPackages

Follow Hadley Style : http://adv-r.had.co.nz/Style.html

DON'T Follow Google R'Style, see : http://www.edii.uclm.es/~useR-2013/slides/145.pdf
