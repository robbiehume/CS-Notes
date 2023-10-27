def func(val):
  if val == "test":
    return True

def test_val(val):
  assert func(val) == True

if __name__ == "__main__"
  test_val("test")
