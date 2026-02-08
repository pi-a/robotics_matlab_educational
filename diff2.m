function [diff2_func] = diff2(func, independentVar)
syms tempVar;
subs_func = subs(func, independentVar,tempVar);
subs_func_diff=diff(subs_func,tempVar);
diff2_func=subs(subs_func_diff,tempVar,independentVar);
end