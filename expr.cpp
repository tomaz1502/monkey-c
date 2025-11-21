#include <string.h>
#include "expr.h"

Expr mk_int(int val) {
  return { .k = Integer, .i_val = val };
}

Expr mk_ident(char* ident) {
  Expr e { .k = Ident };
  strcpy(e.ident, ident);
  return e;
}

Expr mk_op(OperationKind o, Expr* lhs, Expr* rhs) {
  Operation op { .k = o, .lhs = lhs, .rhs = rhs };
  return { .k = OperationK };
}
