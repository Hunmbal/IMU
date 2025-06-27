function u = u(t, offset)
    unitstep = zeros();
    unitstep(t>=(0 + offset)) = 1;
    u = unitstep;
end