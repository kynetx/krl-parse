
// this completely breaks the parser

ruleset not_set {

  rule foo {
    select when foo bar
    noop();
    always {
      ent:locationDatafizzer.put([key],value); 
    }
  }

}