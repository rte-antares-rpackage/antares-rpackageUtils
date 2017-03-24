context("Read/write ini files")

f <- tempfile(fileext = ".ini")

l <- list(
  section1 = list(key1 = 1, key2 = 2),
  section2 = list(key3 = 3, boolean = TRUE, text = "text")
)

describe("writeIniFile", {
  it("writes a list in an .ini file", {
    expect_silent(writeIniFile(l, f))
    expect_true(file.exists(f))
  })
  
  it ("does not overwrite an existing file by default", {
    expect_error(writeIniFile(l, f), "already exists")
  })
  
  it ("overwrites an existing file if overwrite = TRUE", {
    expect_silent(writeIniFile(l, f, overwrite = TRUE))
  })
})


describe("readIniFile", {
  it("reads an .ini file", {
    l2 <- readIniFile(f)
    expect_equal(l2, l)
  })
  
  it("can convert strings to factors", {
    l2 <- readIniFile(f, stringsAsFactors = TRUE)
    expect_is(l2$section2$text, "factor")
  })
})