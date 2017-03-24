context("ID columns")

describe("getIdCols", {
  it("returns the ID columns of a table", {
    mydata <- data.table(area = "fr", timeId = 1, LOAD = 1000)
    expect_equal(getIdCols(mydata), c("area", "timeId"))
  })
})

describe("addIdCol", {
  it("declares new ID cols", {
    addIdCol("dayOfWeek")
    expect_true("dayOfWeek" %in% pkgEnv$idCols)
    mydata <- data.table(area = "fr", timeId = 1, dayOfWeek = "Monday", LOAD = 1000)
    expect_equal(getIdCols(mydata), c("area", "timeId", "dayOfWeek"))
  })
})

describe("reorderCols", {
  it("puts ID columns first", {
    mydata <- data.table(LOAD = rexp(5), timeId = 1:5, BALANCE = rnorm(5))
    reorderCols(mydata)
    expect_equal(names(mydata), c("timeId", "LOAD", "BALANCE"))
  })
})