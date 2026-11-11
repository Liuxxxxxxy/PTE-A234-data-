function GGM_mutation_sankey
% GGM_MUTATION_SANKEY  Evidence-based mutation-selection diagram.
% MATLAB Online / desktop MATLAB. No additional toolbox is required.
% Run: GGM_mutation_sankey
% Exports a vector PDF, PNG and evidence table next to this file.
% The .m source remains fully editable; high-density FIG serialization is
% intentionally skipped because MATLAB Online may time out on large figures.
% One flow unit represents one mutation, not an electric-field magnitude.
% All 23 distinct parental substitutions are included; GG1-only exclusions
% without an explicit individual rationale are kept in a separate reason node.

here = fileparts(mfilename('fullpath'));
if isempty(here), here = pwd; end

% Columns: mutation, origin, rationale ID, retained, evidence, evidence level.
% Evidence levels distinguish site-specific descriptions from background retention.
D = {
 'T45P', 1,1,true, 'Prioritized over neighboring I46V because of stronger links to the coordination networks of both productive parental complexes.', 'Site-specific';
 'A92S', 1,2,true, 'Retained as part of the common mutation background; no prominent individual favorable or unfavorable feature is established in the text.', 'Background retention';
 'Y156H',1,2,true, 'Retained as part of the common mutation background; no prominent individual favorable or unfavorable feature is established in the text.', 'Background retention';
 'I250V',1,1,true, 'Strong parental dynamic correlations are described. A consistently negative field in both GGM complexes is a later observation, not a parental selection criterion.', 'Site-specific, qualitative';
 'Q290R',1,1,true, 'Retained for dynamic correlations with several coordinating residues in parental GG2-R despite a positive local Ex contribution.', 'Site-specific';
 'I274N',1,1,true, 'Parental GG1-S shows strong correlation with His230 and a negative local Ex contribution; these features are not consistently preserved in GGM.', 'Site-specific';
 'I46V', 1,5,false,'Not included because adjacent T45P was prioritized for its more pronounced dynamic links to the parental coordination networks.', 'Site-specific';
 'S111R',1,6,false,'Broad central local Ex distribution, especially in GG2-S, motivated exclusion from the design intended to accommodate both enantiomers.', 'Site-specific';
 'I106C',2,3,true, 'Contributes to substrate stabilization in GG1-S in the per-residue MM/GBSA analysis; introduced to supplement local substrate contacts.', 'Site-specific';
 'S308L',2,3,true, 'Contributes to the hydrophobic substrate-contact network of GG1-S; introduced to supplement local packing.', 'Site-specific';
 'F132V',2,8,false,'Not selected because this GG1-specific substitution is associated with axial substrate coordination, whereas the design aimed to preserve a common equatorial coordination framework.', 'Coordination-based exclusion';
 'H254Q',2,7,false,'Not included because GGM was designed on the GG2 mutation background; the GG2-specific H254G substitution was retained at the same position.', 'GG2-based design';
 'H257Y',2,7,false,'Not included because the design used the GG2 mutation background, with selected GG1 substitutions added only to supplement substrate contacts.', 'GG2-based design';
 'A270V',2,7,false,'Not included because the design used the GG2 mutation background, with selected GG1 substitutions added only to supplement substrate contacts.', 'GG2-based design';
 'L272M',2,7,false,'Not included because the design used the GG2 mutation background, with selected GG1 substitutions added only to supplement substrate contacts.', 'GG2-based design';
 'K77A', 3,4,true, 'Retained within the GG2-based mutation background. A separate site-specific pre-design justification is not given.', 'Background retention';
 'A80V', 3,4,true, 'Retained within the GG2-based mutation background. Negative local Ex in GGM is reported after construction and is not used here as retrospective selection evidence.', 'Background retention';
 'T173N',3,4,true, 'Retained within the GG2-based mutation background. The parental features are not stably preserved in the subsequent GGM evaluation.', 'Background retention';
 'K185R',3,4,true, 'Retained within the GG2-based mutation background. The later negative local Ex in GGM is validation evidence rather than an explicit individual pre-design rationale.', 'Background retention';
 'H254G',3,1,true, 'Strong dynamic correlations with several coordinating residues in parental GG2-R are described.', 'Site-specific, qualitative';
 'R319S',3,4,true, 'Retained within the GG2-based mutation background. A separate site-specific pre-design justification is not given.', 'Background retention';
 'P342S',3,4,true, 'Retained within the GG2-based mutation background. Negative local Ex in GGM is reported after construction and is not used here as retrospective selection evidence.', 'Background retention';
 'F132E',3,6,false,'Unusually broad local Ex distribution motivated pruning. A later summary additionally describes a large positive contribution and cross-system inconsistency.', 'Site-specific';
};

mut = D(:,1); origin = cell2mat(D(:,2)); reason = cell2mat(D(:,3));
keep = cell2mat(D(:,4)); N = size(D,1);
assert(N==23 && sum(keep)==15 && sum(~keep)==8,'Check mutation counts.');
assert(numel(unique(mut))==N,'Mutation identities must be unique.');
assert(all(keep(reason<=4)) && all(~keep(reason>=5)), 'Reason/outcome mismatch.');

sourceNames = {'Shared by GG1 and GG2','GG1-specific','GG2-specific'};
sourceLabels = {sprintf('Shared by GG1\nand GG2\n8 mutations'),...
 sprintf('GG1-specific\n7 mutations'),sprintf('GG2-specific\n8 mutations')};
reasonNames = {'Active-site dynamic coupling','Common mutation background',...
 'Substrate-contact contribution','GG2 background retention',...
 'Neighbor redundancy: T45P prioritized','Broad local Ex distribution',...
 'GG1 mutation background','Axial binding impact'};
reasonLabels = {sprintf('Active-site dynamic\ncoupling'),...
 sprintf('Common mutation\nbackground'),sprintf('Substrate-contact\ncontribution'),...
 sprintf('GG2 background\nretention'),sprintf('Neighbor redundancy:\nT45P prioritized'),...
 sprintf('Broad local E_x\ndistribution'),sprintf('GG1 mutation\nbackground'),...
 sprintf('Axial binding\nimpact')};
outNames = {'GGM','Not included'};

% Colors encode parental origin, never strength of evidence or field direction.
C = [251 217 241; 87 35 77; 92 64 46]/255;
ink=[0.13 0.16 0.19]; accent=[232 157 78]/255; ggmColor=[145 156 104]/255;
W = 1500; H = 1000;
f=figure('Color','w','Name','GGM mutation selection',...
 'NumberTitle','off','Units','pixels','Position',[50 50 W H],...
 'Renderer','painters','Visible','off','PaperPositionMode','auto');
ax=axes('Parent',f,'Position',[0.025 0.10 0.95 0.79]);
hold(ax,'on'); axis(ax,[0 1 0 1]); axis(ax,'off');
set(ax,'Color','w','Clipping','off');

x=[0.16 0.36 0.64 0.91]; nodeW=0.009;
unit=0.023;
sourceCounts=accumarray(origin,1,[3 1]);
reasonCounts=accumarray(reason,1,[8 1]);
outcome=ones(N,1); outcome(~keep)=2;
outCounts=[sum(keep);sum(~keep)];
S=layoutNodes(sourceCounts,unit,0.055,0.95);
M=layoutNodes(ones(N,1),unit,0.010,0.95);
reasonOrder=[1 2 3 4 5 6 8 7]; % Place axial-binding impact above GG1-background exclusions.
Rordered=layoutNodes(reasonCounts(reasonOrder),unit,0.036,0.95);
R=zeros(size(Rordered));
R(reasonOrder,:)=Rordered;
O=layoutNodes(outCounts,unit,0.14,0.95);

% Stable slot allocation makes all flows conserve mutation counts at each node.
sUsed=zeros(3,1); rInUsed=zeros(8,1);
for k=1:N
 si=origin(k); ri=reason(k);
 sy=S(si,2)-sUsed(si)*unit; sUsed(si)=sUsed(si)+1;
 my=M(k,2); ry=R(ri,2)-rInUsed(ri)*unit; rInUsed(ri)=rInUsed(ri)+1;
 col=C(si,:);
 flow(ax,x(1)+nodeW,x(2),sy,my,unit,col,0.70,mut{k});
 flow(ax,x(2)+nodeW,x(3),my,ry,unit,col,0.70,mut{k});
end
rOutUsed=zeros(8,1); oUsed=zeros(2,1);
for k=1:N
 ri=reason(k); oi=outcome(k);
 ry=R(ri,2)-rOutUsed(ri)*unit; rOutUsed(ri)=rOutUsed(ri)+1;
 oy=O(oi,2)-oUsed(oi)*unit; oUsed(oi)=oUsed(oi)+1;
 flow(ax,x(3)+nodeW,x(4),ry,oy,unit,C(origin(k),:),0.70,mut{k});
end

% Nodes and direct labels, drawn over ribbons for legibility.
for j=1:3
 node(ax,x(1),S(j,:),nodeW,C(j,:));
 label(ax,x(1)-0.012,mean(S(j,:)),sourceLabels{j},'right',14,ink,true);
end
for k=1:N
 col=C(origin(k),:);
 node(ax,x(2),M(k,:),nodeW,col);
 t=label(ax,x(2)+nodeW+0.008,mean(M(k,:)),mut{k},'left',10.5,ink);
 t.UserData=D(k,:); % Select object in the saved FIG to inspect its evidence.
end
for j=1:8
 col=ggmColor; if j>=5, col=accent; end
 node(ax,x(3),R(j,:),nodeW,col);
 label(ax,x(3)+nodeW+0.009,mean(R(j,:)),reasonLabels{j},'left',13,ink,true);
end
node(ax,x(4),O(1,:),nodeW,ggmColor);
node(ax,x(4),O(2,:),nodeW,accent);
label(ax,x(4)+nodeW+0.010,mean(O(1,:)),sprintf('GGM\n15 mutations'),'left',14,ink,true);
label(ax,x(4)+nodeW+0.010,mean(O(2,:)),sprintf('Not included\n8 mutations'),'left',13,ink,true);

headings={'Parental origin','Mutation','Selection rationale','Outcome'};
for j=1:4
 label(ax,x(j),1.025,headings{j},'center',14,ink,true);
end
annotation(f,'textbox',[0.03 0.92 0.94 0.06],...
 'String','Parental mutation selection for GGM','EdgeColor','none',...
 'FontName','Times New Roman','FontSize',19,'FontWeight','bold','Color',ink);
annotation(f,'textbox',[0.03 0.015 0.94 0.065],...
 'String',{...
 'Flow width represents mutation count, not electric-field magnitude or catalytic contribution.',...
 'All 23 distinct parental substitutions are shown. GGM uses the GG2 background with selected GG1 contact mutations.',...
 'F132V is separately excluded because of its association with axial substrate coordination.'},...
 'EdgeColor','none','FontName','Times New Roman','FontSize',10.5,...
 'FontWeight','bold','Color',[0.32 0.34 0.37]);

% Export provenance and the exact plotted mutation/rationale mapping.
Origin=reshape(sourceNames(origin),[],1);
Rationale=reshape(reasonNames(reason),[],1);
Outcome=reshape(outNames(outcome),[],1);
T=table(mut,Origin,Rationale,Outcome,D(:,5),D(:,6),...
 'VariableNames',{'Mutation','Parental_origin','Selection_rationale','Outcome','Evidence','Evidence_level'});
writetable(T,fullfile(here,'GGM_selection_evidence.csv'));
% Print-based vector export is generally more robust in MATLAB Online.
print(f,fullfile(here,'GGM_mutation_sankey.pdf'),'-dpdf','-painters');
% Transparent PNG preview is optional: a graphics-client timeout should not invalidate the PDF.
try
 exportgraphics(f,fullfile(here,'GGM_mutation_sankey.png'),'Resolution',220,'BackgroundColor','none');
catch ME
 warning('GGM:PNGExportSkipped','PDF and source were generated, but transparent PNG export failed: %s',ME.message);
end
fprintf('Done. Exported editable MATLAB source, vector PDF and evidence CSV to:\n%s\n',here);
fprintf('All GG1-specific mutations shown (7): I106C, F132V, H254Q, H257Y, A270V, L272M, S308L.\n');
fprintf('GG1-specific included in GGM (2): I106C, S308L. Not included (5): F132V, H254Q, H257Y, A270V, L272M.\n');
fprintf('Shared included: 6/8; GG2-specific included: 7/8.\n');
fprintf('Other not included: shared I46V, S111R; GG2-specific F132E.\n');
end

function B=layoutNodes(counts,unit,gap,top)
% Bottom/top pairs. Node height equals count times the same flow unit.
B=zeros(numel(counts),2);
for j=1:numel(counts)
 B(j,:)=[top-counts(j)*unit,top];
 top=B(j,1)-gap;
end
assert(all(B(:,1)>0),'Layout exceeds available height.');
end

function flow(ax,x0,x1,y0,y1,h,c,alpha,name)
t=linspace(0,1,28); ease=3*t.^2-2*t.^3;
xx=x0+(x1-x0)*t; yy=y0+(y1-y0)*ease;
q=patch(ax,[xx fliplr(xx)],[yy fliplr(yy-h)],c,...
 'EdgeColor','none','FaceAlpha',alpha,'DisplayName',name);
q.UserData=name;
end

function node(ax,x,b,w,c)
rectangle(ax,'Position',[x b(1) w b(2)-b(1)],...
 'FaceColor',c,'EdgeColor','none');
end

function q=label(ax,x,y,s,align,sz,col,bold)
if nargin < 8
 bold=false;
end
fontWeight='normal';
if bold
 fontWeight='bold';
end
q=text(ax,x,y,s,'FontName','Times New Roman','FontSize',sz,...
 'FontWeight',fontWeight,'Color',col,...
 'HorizontalAlignment',align,'VerticalAlignment','middle',...
 'Interpreter','tex','BackgroundColor','white','Margin',1.5,'Clipping','off');
end
