ruleset test_1 {
 
  global {
    y = x-1;
    z = z - 1;
    Var = var1 + var2 - 1;
  }
 
  rule foo {
    select when web pageview
    pre {
      x = 1;
    }
    noop();
  }
}