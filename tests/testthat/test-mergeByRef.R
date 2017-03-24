context("mergeByRef")

x <- data.table(a = 1:5, b = rnorm(5))
y <- data.table(a = 1:5, c = rnorm(5), d = rnorm(5))

describe("mergeByRef", {
  it ("merges two data.tables", {
    x <- copy(x)
    y <- copy(y)
    expect_silent(mergeByRef(x, y))
    expect_false(is.null(x$c))
    expect_equal(x$c, y$c)
    expect_false(is.null(x$d))
    expect_equal(x$d, y$d)
  })
  
  it("can copy only some columns", {
    x <- copy(x)
    y <- copy(y)
    expect_silent(mergeByRef(x, y, colsToAdd = "c"))
    expect_false(is.null(x$c))
    expect_equal(x$c, y$c)
    expect_true(is.null(x$d))
  })
  
  it("works when missing rows in y", {
    x <- copy(x)
    y <- copy(y)
    expect_silent(mergeByRef(x, y[1:3,]))
    expect_false(is.null(x$c))
    expect_equal(x$c, c(y$c[1:3], NA, NA))
    expect_false(is.null(x$d))
    expect_equal(x$d, c(y$d[1:3], NA, NA))
  })
})
