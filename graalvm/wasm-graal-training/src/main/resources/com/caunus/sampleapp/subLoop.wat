(module
  (func $subLoop (export "subLoop") (param i64) (result i64)
    local.get 0
    i64.const 1
    i64.lt_s
    if (result i64)
      local.get 0
    else
      local.get 0
      i64.const 1
      i64.sub
      call $subLoop
    end))