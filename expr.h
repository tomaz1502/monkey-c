typedef enum OperationKind {
    Plus,
    Mult,
    Sub,
    Div,
    Neg,
} OperationKind;

typedef struct Expr Expr;

typedef struct Operation {
  OperationKind k;
  Expr* lhs;
  Expr* rhs;
} Operation;

typedef enum ExprKind {
    Ident,
    Integer,
    OperationK,
} ExprKind;

typedef struct Expr {
    ExprKind k;
    union {
      char ident[32];
      int i_val;
      Operation* op;
    };
} Expr;

Expr mk_int(int val);

Expr mk_ident(char* ident);

Expr mk_op(OperationKind o, Expr* lhs, Expr* rhs);
