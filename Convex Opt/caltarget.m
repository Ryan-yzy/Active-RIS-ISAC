function target=caltarget(v,q1,Q2,q3,q4)
    vhat=reshape(v*v',[],1);
    target=2*real(q1'*vhat)-vhat'*Q2*vhat-(q3'+q4')*vhat;
end