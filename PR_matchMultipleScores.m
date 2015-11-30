function [TPbyP, TPbyT] = PR_matchMultipleScores(Gt, Det, S, T, PR_match)

  TPbyP = cell(length(T), 1);
  TPbyT = zeros(length(T), length(Gt));

  % process each threshold independently
  for t=1:length(T)
    %fprintf('%d%% items (%d of %d) under minimum score %f\n', round( 100*sum(S<=T(t))/length(S) ), sum(S<=T(t)), length(S), T(t));
  
    [tpbyp, tpbyt] = PR_match( Gt , Det( S>T(t) ) );
    TPbyP{t} = tpbyp;
    TPbyT(t,:) = tpbyt;
    
    %fprintf('%d, %d, %f\n', sum(tpbyp), length(tpbyp), sum(tpbyp) / length(tpbyp));
    %fprintf('%d, %d, %f\n', sum(tpbyt), length(tpbyt), sum(tpbyt) / length(tpbyt));        
    %assert(sum(tpbyp) == sum(tpbyt));
  end

end