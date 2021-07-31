%%%%  This code emulates(wat is it??) linear Pulse code Modulation     %%%%

%%%%%%%%%%    No Copyright (NoC) of Aditya Kumar     %%%%%%%%%%%%%%%%%%%%
% Everyone is permitted to copy and distribute copies of this code  % 






clc 
close all
clear all

choice=0;
%flag_iteration=1;

while(choice~=7)                                                            %Exit from menu
choice=menu('Pulse code modulation','Get PCM Parameters','Plot Input Signal','Sample','Quantize','Encode','Decode','Quit');

switch choice
    case 1
    close all
    clear all
    choice=1;
    
    h1='o';
    h2='o';
    h3='o';
    h4='o';
    h5='o';
    
   %=========Check no of times the loop runs=============     
     %   flag_iteration=flag_iteration+1;
      %  if (flag_iteration>2)
       %     close all
        %end
%==========================PCM parameters=========================
prompt={'Enter frequency of input sine wave','Enter amplitude for input sine wave','Enter n value for n-bit PCM','Enter no. of samples per second'};
dlg_title='PCM Parameters';
num_lines=1;
def={'2','5','8','20'};
options.Resize='on';
answer=inputdlg(prompt,dlg_title,num_lines,def,options);

% Conversion from string to number required
freq=str2double(answer{1});
amp=str2double(answer{2});
word_length=str2double(answer{3});
fs=str2double(answer{4});

%=============To generate input signal================================
t=0:.001:1;
w=2*pi*freq;
input_sig =amp*(sin(t*w));


         

%========Used later to create a window using 'figure' function========
scrsz = get(0,'ScreenSize');                                                %get dimension of screen


%=================================================================


  
%===================SAMPLING======================================


[~,n]=size(input_sig);
sample_size=round(n/(fs-1));                                                %To get n samples we divide data by n-1 so to get n points(samples)    %Input signal divided into samples with each sample separated by sample_size
sampled_signal=zeros(1,fs);                                                 
index=1;

for i=1:sample_size-1:n
    if(i>n-sample_size)
        i=n;
    end
    
    sampled_signal(index)=input_sig(i);
	index=index+1;
    
end


%===========Begin Quantization==============================
vmax=5;                                                                     %get upper limit of quantization
vmin=-5;                                                                    %get lower limit of quantization
lsb=(vmax-vmin)/((2^word_length)-1);                                        %concept-if we divide a line segment in 2 parts  we get three points
levels=vmin:lsb:vmax;                                                    %generate level vector

partition=(vmin-(.5*lsb)):lsb:(vmax+(.5*lsb));                              %introduce +(-)1/2*LSB into levels
[~,index_levels]=size(levels);

%========generate quantized value out of sample data =========

quantiz_signal=zeros(1,index-1);                                            %index-1??? see previous for loop, there index value exceeds size of sampled_signal in the last iteration

for i=1:index-1                                                             %to increment the sampled_signal vector
 
    for j=1:index_levels                                                    %to increment the 'partition' & 'levels' vectors
  %============check if input is less than vmin============================================================
        if (sampled_signal(i)<partition(1))                                 %Compare sample with upper and lower partition of a level
                                                                            %if sample is between partitions, give that value of level to 
                                                                            %the quantize_signal array at the index equal to that of sample.
             quantiz_signal(i)=vmin;                                        %This will generate quantized array of same size of sample's array
             bin_val=dec2bin(0,word_length);                                %for example- In 4-bit PCM quantize level 1 corresponds to 0x0 & level 16 is eqv to 0xf         
         
              
                                                                            %Following commands to arrange string bits columnwise and put it at appropriate index of data stream
         
              val_rearrange=bin_val(:);                                     %Make it i:1 matrix 
              rearrange_index=((i-1)*word_length)+1;                        %Example- for 4 bit insert at 1st,5th,9th,13th..index
              data_stream(rearrange_index:(rearrange_index+word_length-1),1)=val_rearrange;
        end
 %==============check if input is greater than vmax===========================================================
        if (sampled_signal(i)>partition(end))
            
            quantiz_signal(i)=vmax;
             bin_val=dec2bin((2^word_length)-1,word_length);                %for example- In 4-bit PCM quantize level 1 corresponds to 0x0 & level 16 is eqv to 0xf         
         
              
                                                                            %Following commands to arrange string bits columnwise and put it at appropriate index of data stream
         
              val_rearrange=bin_val(:);                                     %Make it i:1 matrix 
              rearrange_index=((i-1)*word_length)+1;                        %Example- for 4 bit insert at 1st,5th,9th,13th..index
              data_stream(rearrange_index:(rearrange_index+word_length-1),1)=val_rearrange;
        end
 %=========================================================================       
        
        if (sampled_signal(i)>=partition(j))
             if (sampled_signal(i)<partition(j+1))
                quantiz_signal(i)=levels(j);
       
                
 %=====Simultaneously generating binary stream for each quantized value====
              bin_val=dec2bin(j-1,word_length);                             %for example- In 4-bit PCM quantize level 1 corresponds to 0x0 & level 16 is eqv to 0xf         
         
              
                                                                            %Following commands to arrange string bits columnwise and put it at appropriate index of data stream
         
              val_rearrange=bin_val(:);                                     %Make it i:1 matrix 
              rearrange_index=((i-1)*word_length)+1;                        %Example- for 4 bit insert at 1st,5th,9th,13th..index
              data_stream(rearrange_index:(rearrange_index+word_length-1),1)=val_rearrange;
              
            
                         
                
             end
        end
        
    end
end
%==========================================================================

[size_data,~]=size(data_stream);

%=================create Encoded data stream array ========================
%==============Encoded according to Natural Binary Coding==================
dec_val=zeros(size_data,1);
for i=1:size_data
dec_val(i,1)=str2double(data_stream(i,1));                                  %cant plot string array. so convert to numbers
end


%===========================Decoding=======================================

k=1;

for i=1:length(data_stream)/word_length                                     %Arrange data stream into word_length sized binary strings for conversion
    for j=1:1:word_length
        bin_rearrange(i,j)=data_stream(k);                                  %Ignoring this Warning!!!!
        k=k+1;
    end
end
bin_rearrange
bin_dec=bin2dec(bin_rearrange);
decoded_val=zeros(length(bin_dec),1);
for i=1:length(bin_dec)                                                     %bin_dec contain dec equivalents ranging from 0 to max for the word
decoded_val(i)=levels(bin_dec(i)+1);                                        %therefore dec equivalent 0 corresponds to level 1.
                                                                            %thus get quantized values from level(dec.equiv+1) and store in an array
end


%==============Various Plot data========================================== 

case 2
h1=figure('Name','Input Signal','NumberTitle','off','Position',[122 scrsz(4)/3 scrsz(3)/2.2 scrsz(4)/2.2]); %Position figure accordingly
plot(t,input_sig);
axis([-inf inf -1.2*amp 1.2*amp]);
    
case 3

h2=figure('Name','Sampled Signal','NumberTitle','off','Position',[scrsz(3)/1.8 scrsz(4)/3 scrsz(3)/2.2 scrsz(4)/2.2]);
stem(sampled_signal);

case 4
if(~ischar(h1))
close(h1);
end
h3=figure('Name','Quantized Signal','NumberTitle','off','Position',[122 1 scrsz(3)/2.2 scrsz(4)]);

stairs(quantiz_signal)
ylim([vmin vmax])
                                                                            %only to customize plot
set(gca,'YTick',vmin:lsb:vmax)



    
case 5
   
  h4=figure('Name','Pulse Code Modulated Stream','NumberTitle','off','Position',[1 scrsz(4)/3 scrsz(3) scrsz(4)/2.5]);

  stairs(dec_val');
  axis([1 100 -3 4]);
  set(gca,'YTick',-3:1:4);
  set(gca,'YTicklabel',{' ',' ',' ','0','1',' ',' ',' '});
case 6
    if(~ischar(h2))
    close(h2);
    end
    if(~ischar(h4))
    close(h4);
    end
    h5=figure('Name','Decoded Signal','NumberTitle','off','Position',[scrsz(3)/1.8 scrsz(4)/3 scrsz(3)/2.2 scrsz(4)/2.2]);
    plot(decoded_val);
    grid on;
    %ylim([vmin vmax])


end
end
close all

