# test if an object has a given attribute and eventually check the value of the
# attribute
expect_attr <- function(x, attrName, value = NULL) {
  lab <- deparse(substitute(object))
  
  missingAttr <- is.null(attr(x, attrName))
  
  expect(!missingAttr, sprintf("%s has no attribute '%s'", lab, attrName))
  
  if(!missingAttr && !is.null(value)) {
    comp <- compare(attr(x, attrName), value)
    expect(
      comp$equal,
      sprintf("Attribute '%s' of %s has incorrect value:\n%s",
              lab, attrName, comp$message)
    )
  }
}