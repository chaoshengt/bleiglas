/*
 Produced with: tools::package_native_routine_registration_skeleton(".")
 */

#include <R.h>
#include <Rinternals.h>
#include <stdlib.h> // for NULL
#include <R_ext/Rdynload.h>

/* FIXME: 
 Check these declarations against the C/Fortran source code.
 */

/* .Call calls */
extern SEXP _bleiglas_pnp(SEXP, SEXP, SEXP, SEXP);
extern SEXP _bleiglas_pnpmulti(SEXP, SEXP, SEXP, SEXP);

static const R_CallMethodDef CallEntries[] = {
  {"_bleiglas_pnp",      (DL_FUNC) &_bleiglas_pnp,      4},
  {"_bleiglas_pnpmulti", (DL_FUNC) &_bleiglas_pnpmulti, 4},
  {NULL, NULL, 0}
};

void R_init_bleiglas(DllInfo *dll)
{
  R_registerRoutines(dll, NULL, CallEntries, NULL, NULL);
  R_useDynamicSymbols(dll, FALSE);
}