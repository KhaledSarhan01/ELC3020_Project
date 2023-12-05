%Signal processing

%Reading all the Signals
    [raw_audio_1,Sampling_Freq1]= audioread("Signals/Short_BBCArabic2.wav");
    [raw_audio_2,Sampling_Freq2]= audioread("Signals/Short_FM9090.wav");
    [raw_audio_3,Sampling_Freq3]= audioread("Signals/Short_QuranPalestine.wav"); 
    [raw_audio_4,Sampling_Freq4]= audioread("Signals/Short_RussianVoice.wav");
    [raw_audio_5,Sampling_Freq5]= audioread("Signals/Short_SkyNewsArabia.wav");
%Stereo Audio into Single Channel audio
    mono_audio_1=sum(raw_audio_1,2)/2;
    mono_audio_2=sum(raw_audio_2,2)/2;
    mono_audio_3=sum(raw_audio_3,2)/2;
    mono_audio_4=sum(raw_audio_4,2)/2;
    mono_audio_5=sum(raw_audio_5,2)/2;
%Pad all the signals and increasing the Sampling rate "Up-Sampling"
    Scale_Factor=10;
    message_length=max([length(mono_audio_1),length(mono_audio_2),length(mono_audio_3),length(mono_audio_4),length(mono_audio_5)]);
    
    message_1=interp(padarray(mono_audio_1,message_length-length(mono_audio_1),0,'post'),Scale_Factor);
    message_2=interp(padarray(mono_audio_2,message_length-length(mono_audio_2),0,'post'),Scale_Factor);
    message_3=interp(padarray(mono_audio_3,message_length-length(mono_audio_3),0,'post'),Scale_Factor);
    message_4=interp(padarray(mono_audio_4,message_length-length(mono_audio_4),0,'post'),Scale_Factor);
    message_5=interp(padarray(mono_audio_5,message_length-length(mono_audio_5),0,'post'),Scale_Factor);
 
    %==========================Optional==================================
 %Estimating the bandwidth
%     Sampling_Freq=max([Sampling_Freq1,Sampling_Freq2,Sampling_Freq3,Sampling_Freq4,Sampling_Freq5])*Scale_Factor;
%     Freq=linspace(0,Sampling_Freq,message_length*Scale_Factor);
%     
%     mag_spectrum_message_1=abs(fft(message_1))/message_length;
%     mag_spectrum_message_2=abs(fft(message_2))/message_length;
%     mag_spectrum_message_3=abs(fft(message_3))/message_length;
%     mag_spectrum_message_4=abs(fft(message_4))/message_length;
%     mag_spectrum_message_5=abs(fft(message_5))/message_length;
%     
%     figure(1);
%     subplot(2,3,1);
%     plot(Freq(1:message_length/2), mag_spectrum_message_1(1:message_length/2));
%     title('Frequency Spectrum of Message 1');
%     xlabel('Frequency (Hz)');
%     ylabel('Magnitude');
%     subplot(2,3,2);
%     plot(Freq(1:message_length/2), mag_spectrum_message_2(1:message_length/2));
%     title('Frequency Spectrum of Message 2');
%     xlabel('Frequency (Hz)');
%     ylabel('Magnitude');
%     subplot(2,3,3);
%     plot(Freq(1:message_length/2), mag_spectrum_message_3(1:message_length/2));
%     title('Frequency Spectrum of Message 3');
%     xlabel('Frequency (Hz)');
%     ylabel('Magnitude');
%     subplot(2,3,4);
%     plot(Freq(1:message_length/2), mag_spectrum_message_4(1:message_length/2));
%     title('Frequency Spectrum of Message 4');
%     xlabel('Frequency (Hz)');
%     ylabel('Magnitude');
%     subplot(2,3,5);
%     plot(Freq(1:message_length/2), mag_spectrum_message_5(1:message_length/2));
%     title('Frequency Spectrum of Message 5');
%     xlabel('Frequency (Hz)');
%     ylabel('Magnitude');
   %From the Graphes BaseBand BandWidth =10kHz 
 %export all messages in Command window
%audiowrite("message_1_.wav",message_1,Sampling_Freq);
%audiowrite("message_2_.wav",message_2,Sampling_Freq);
%audiowrite("message_3_.wav",message_3,Sampling_Freq);
%audiowrite("message_4_.wav",message_4,Sampling_Freq);
%audiowrite("message_5_.wav",message_5,Sampling_Freq);

%Second Block: AM modulator
carrier_freq=100*(10^3);                         %Carrier frequency 
delta_freq=55*(10^3);                            %Frequency Difference
Ts=1/Sampling_Freq;                              %Sampling Time   
t = linspace(0, 16, message_length*Scale_Factor);%Time Step
Ac=1;                                            %Carrier Amplitude

%modulating the First message
Fc_1=carrier_freq+0*delta_freq;
Carrier_1=(Ac*cos(2*pi*t*Fc_1))';
modulatedSignal_1=message_1 .* Carrier_1;
%modulating the Second message
Fc_2=(carrier_freq+1*delta_freq);
Carrier_2=(Ac*cos(2*pi*t*Fc_2))';
modulatedSignal_2=message_2 .* Carrier_2;
%modulating the Third message
Fc_3=(carrier_freq+2*delta_freq);
Carrier_3=(Ac*cos(2*pi*t*Fc_3))';
modulatedSignal_3=message_3 .* Carrier_3;
%modulating the Fourth message
Fc_4=(carrier_freq+3*delta_freq);
Carrier_4=(Ac*cos(2*pi*t*Fc_4))';
modulatedSignal_4=message_4 .* Carrier_4;
%modulating the Fifth message
Fc_5=(carrier_freq+4*delta_freq);
Carrier_5=(Ac*cos(2*pi*t*Fc_5))';
modulatedSignal_5=message_5 .* Carrier_5;
%adding all the signals and send them into the channel
dsb_sc_modulatedSignal= modulatedSignal_5+modulatedSignal_4+...
                        modulatedSignal_3+modulatedSignal_2+modulatedSignal_1;
%==========================Optional==================================
%ploting Spectrum of the modulated signal 
% modulated_length=length(dsb_sc_modulatedSignal);
% mag_spectrum_modulated_1=abs(fft(dsb_sc_modulatedSignal))/modulated_length;
%     figure(2);
%     plot(Freq(1:modulated_length/2), mag_spectrum_modulated_1(1:modulated_length/2));
%     title('Frequency Spectrum of Modulated 1');
%     xlabel('Frequency (Hz)');
%     ylabel('Magnitude');

% figure(2);
% subplot(3,1,1);
% plot(t, message_1);
% title('Message Signal');
% 
% subplot(3,1,2);
% plot(t, Carrier);
% title('Carrier Signal');
% 
% subplot(3,1,3);
% plot(t, dsb_sc_modulatedSignal);
% title('DSB-SC Modulated Signal');

