
function [RWE, reconstructed_data] = wavelet_packet_decomposition_reconstruct(raw_data, soft_threshold)
%
% The signal is decomposed by 4-layer wavelet packet,
% denoised by soft threshold and reconstructed
%
% Inputs:
%           raw_data - Signal to be processed(Channel * Sampling points)
%     soft_threshold - Value of soft threshold
%
% Outputs:
%                RWE - Feature of relative wavelet energy
% reconstructed_data - The data after preprocessing
%
for i = 1:size(raw_data,1)
    wpt = wpdec(raw_data(i,:),4,'dmey');
    %% Reorder the nodes in order of increasing frequency
    nodes = [15;16;17;18;19;20;21;22;23;24;25;26;27;28;29;30];
    ord = wpfrqord(nodes); 
    nodes_ord = nodes(ord); %Rearranged wavelet coefficients
    %% Reconstructe the wavelet nodes
    for i_rex4 = 1:16
        rex4(:,i_rex4) = wprcoef(wpt,nodes_ord(i_rex4));
    end
    %% Calculate the wavelet packet coefficients of each frequency band
    for i_cfs4 = 1:16
        cfs4(i_cfs4,i,:) = wpcoef(wpt,nodes_ord(i_cfs4));
    end
    %% Calculate the energy value of each frequency band
    for i_E_cfs4 = 1:16
        ENRG_cfs4(i_E_cfs4)=norm(squeeze(cfs4(i_E_cfs4,i,:)),2)^2;
    end
    E_total=sum(ENRG_cfs4);
    for i_power_node = 2:16
        power_node(i_power_node-1)= 100*ENRG_cfs4(i_power_node)/E_total; % Calculate the relative wavelet energy
    end
    RWE(i,:)=power_node;
    
    
    %% Denoising through soft threshold
    for i_soft_thr = 1:16
        soft_thr(i_soft_thr,i,:)=wthresh(cfs4(i_soft_thr,i,:),'s',soft_threshold);
    end
    %% Reconstructed signal
    t3(i,:)=write(wpt,'cfs',16,squeeze(soft_thr(2,i,:))','cfs',17,squeeze(soft_thr(3,i,:))','cfs',...
            18,squeeze(soft_thr(4,i,:))','cfs',19,squeeze(soft_thr(5,i,:))','cfs',20,...
            squeeze(soft_thr(6,i,:))','cfs',21,squeeze(soft_thr(7,i,:))','cfs',22,...
            squeeze(soft_thr(8,i,:))','cfs',23,squeeze(soft_thr(9,i,:))','cfs',24,...
            squeeze(soft_thr(10,i,:))','cfs',25,squeeze(soft_thr(11,i,:))','cfs',26,...
            squeeze(soft_thr(12,i,:))','cfs',27,squeeze(soft_thr(13,i,:))','cfs',28,...
            squeeze(soft_thr(14,i,:))','cfs',29,squeeze(soft_thr(15,i,:))','cfs',30,squeeze(soft_thr(16,i,:))');

    reconstructed_data(i,:)=wprec(t3(i,:));
    
end
