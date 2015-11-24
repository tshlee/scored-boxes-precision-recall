function [tpbyp, tpbyt] = PR_match(Ann, Det)

  tpbyp = false(1, length(Det));
  tpbyt = false(1,length(Ann));
  
  [ann_u, ann_rep, ann_grp] = unique({Ann.id});
  Det_ = {Det.id};  
  for u=1:length(ann_u)
    ann_sub = ann_grp == ann_grp(ann_rep(u));    
    det_sub = strcmp(Det_, ann_u{u});
    
    Br_ann = vertcat( Ann(ann_sub).br );
    Br_det = vertcat( Det(det_sub).br );
    
    if isempty(Br_det)
      Br_det = zeros(0,4);
    end
    Int = rectint(Br_ann, Br_det);  % bsxfun semantics
    
    
    Area_ann = prod(Br_ann(:,3:4), 2);
    Area_det = prod(Br_det(:,3:4), 2);
    Union = bsxfun(@plus, Area_ann, Area_det') - Int;
    
    
    match = (Int ./ Union) > 0.4;
    
    
    % set the relevant detections (sufficiently intersected with an annotation)
    tpbyp(det_sub) = any(match, 1);
    
    % set the detected (relevant) annotations (sufficiently intersected with a detection)
    tpbyt(ann_sub) = any(match, 2);
  end
end