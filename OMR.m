format short g
myFolder = 'Your folder path';

filePattern = fullfile(myFolder, '*.jpg');
theFiles = dir(filePattern);
DogruCevaplar=["A", "C" ,"B", "D", "B" ,"E" ,"C" ,"A" ,"D", "B" ,"E" ,"C", "A","D","B","E","C","B","D","A"]; 
for k = 1 : length(theFiles)
  baseFileName = theFiles(k).name;
  fullFileName = fullfile(myFolder, baseFileName);
  
imageArray = imread(fullFileName);
Igray=rgb2gray(imageArray);
level = 0.8;
Ithresh = im2bw(Igray,level);
bw = bwareaopen(~Ithresh,60);
se=strel('disk',5);
bw2=imopen(~bw,se);
bw2=~bw2;

                 %ROTATION%
%/////////////////////////////////////////////////////////////////
%////////////////////////////////////////////////////////////////
[B,L] = bwboundaries(bw2,'noholes');
 for k = 1:length(B)
  boundary = B{k};
end
stats = regionprops(L,'Area','Centroid');
threshold = 0.88;
centroid1=[];
for k = 1:length(B)
 boundary = B{k};
 delta_sq = diff(boundary).^2;    
 perimeter = sum(sqrt(sum(delta_sq,2)));
 area = stats(k).Area;
 metric = 4*pi*area/perimeter^2;
 if metric >= threshold && stats(k).Area>8300 
    centroid = stats(k).Centroid;
    centroid1=[centroid1 centroid];
  end
end

a= atan2(centroid1(6)-centroid1(2),centroid1(5)-centroid1(1) );
rotation=a*180/pi;
J = imrotate(bw2,rotation);

                 %CUTING%
%/////////////////////////////////////////////////////////////////
%////////////////////////////////////////////////////////////////
[F,U] = bwboundaries(J,'noholes');

for k = 1:length(F)
  boundary = F{k};
 
end
stats = regionprops(U,'Area','Centroid');

centroid2=[];
for k = 1:length(F)

  boundary = F{k};
  delta_sq = diff(boundary).^2;    
  perimeter = sum(sqrt(sum(delta_sq,2)));

  area = stats(k).Area;
  metric = 4*pi*area/perimeter^2;
  if metric >= threshold && stats(k).Area>8300 
    centroid = stats(k).Centroid;
    centroid2=[centroid2 centroid];
  end
end
bw3 = imcrop(J,[centroid2(1) centroid2(2) centroid2(3)-centroid2(1) centroid2(4)-centroid2(2)]);




  
                           %ÖGRENCI NUMARASI%
%//////////////////////////////////////////////////////////////////////////////////////////////////////////
%/////////////////////////////////////////////////////////////////////////////////////////////////////////

ony=[];  onx=[];
ONumarasi1=[];
xxon=[259:329,337:408,415:486,493:564,572:642,650:721,728:799,806:877,884:955,962:1033];
yyon=[63:134,143:213,220:290,296:367,373:444,450:521,527:598,604:674,681:752,759:829];

for question=1:10 
 Y=98+(77*(question-1));
 for option=1:10
 X=294+(78*(option-1)); 
 onx=[onx,X];
 end
 ony=[ony,Y];

end
ony; onx;
for n3=1:10
 y_value=ony(n3);
 
 for n4=(((n3-1)*10)+1):(((n3-1)*10)+10)
 
  x_value=onx(n4);
 
 P=bw3(x_value,y_value);
 if P==1

 if(ismember(y_value,yyon)&&(x_value>=259)&&(x_value<=329))
     if n3==1
         ONumarasi='B';
     else 
         ONumarasi='0';
     end

 elseif (ismember(y_value,yyon)&& (x_value>=337)&&(x_value<=408))
      if n3==1
         ONumarasi='G';
     else 
         ONumarasi='1';
     end
 elseif (ismember(y_value,yyon)&& (x_value>=415)&&(x_value<=486))
      if n3==1
         ONumarasi='D';
     else 
         ONumarasi='2';
     end

 elseif (ismember(y_value,yyon)&& (x_value>=493)&&(x_value<=564))
      if n3==1
         ONumarasi='Y';
     else 
         ONumarasi='3';
     end

 elseif (ismember(y_value,yyon)&& (x_value>=572)&&(x_value<=642))
     if n3==1
         ONumarasi='U';
     else 
         ONumarasi='4';
     end
elseif (ismember(y_value,yyon)&& (x_value>=650)&&(x_value<=721))
     if n3==1
         ONumarasi='E';
     else 
         ONumarasi='5';
     end
elseif (ismember(y_value,yyon)&& (x_value>=728)&&(x_value<=799))
     if n3==1
         ONumarasi='T';
     else 
         ONumarasi='6';
     end
elseif (ismember(y_value,yyon)&& (x_value>=806)&&(x_value<=877))
     if n3==1
         ONumarasi='M';
     else 
         ONumarasi='7';
     end
elseif (ismember(y_value,yyon)&& (x_value>=884)&&(x_value<=955))
    ONumarasi='8';
     
elseif (ismember(y_value,yyon)&& (x_value>=962)&&(x_value<=1033))
    ONumarasi='9';
    

 end
 end
 
 


 end
 
ONumarasi1=[ONumarasi1 ONumarasi];
end

                         %KITAPCIK%
%///////////////////////////////////////////////////////////////////////////
%//////////////////////////////////////////////////////////////////////////

Xkontrol=[];
Ykontrol=[];
xxkitapcik=870:941;
yykitapcik=[1333:1404,1459:1530,1583:1654,1713:1784];
xkitapcik=905;
ykitapcik=[1368,1494,1618,1748];
for n4=1:4
 y_value=ykitapcik(n4);
 x_value=xkitapcik;
 
 K=bw3(x_value,y_value);
 if K==1

 if(ismember(x_value,xxkitapcik)&&(y_value>=1333)&&(y_value<=1404))
 Kitapcik='A';
 
 elseif (ismember(x_value,xxkitapcik)&& (y_value>=1459)&&(y_value<=1530))
 Kitapcik='B';
 
 elseif (ismember(x_value,xxkitapcik)&& (y_value>=1583)&&(y_value<=1654))
 Kitapcik='C';
 
 elseif (ismember(x_value,xxkitapcik)&& (y_value>=1713)&&(y_value<=1784))
 Kitapcik='D';
 end
 end
 
end




                                      %1.CEVAP FORMU%
 %////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////%
 %////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////%
sab1=bw3(1191,107);
sab2=bw3(1211,107);
sab3=bw3(1191,494);
sab4=bw3(1211,494);
 if sab1==1&&sab2==1&&sab3==1&&sab4==1

y=[];  x=[];
Cevap1=[];

xx=[1229:1300,1308:1379,1387:1458,1462:1532,1539:1609,1615:1686,1692:1763,1769:1840,1846:1916,1920:1991,1995:2066,2072:2143,2149:2220,2226:2296,2305:2375,2383:2454,2462:2533,2539:2609,2618:2688,2695:2766];
yy=[133:204,216:286,300:371,381:452,460:531];
for question=1:20 
 X=1267+(77*(question-1));
 for option=1:5
 Y=169+(81*(option-1)); 
 y=[y,Y];
 end
 x=[x,X];
end
y; x;
for n3=1:20
 x_value=x(n3);
 fazlaisaret=0;
 bosmu=0;
 for n4=(((n3-1)*5)+1):(((n3-1)*5)+5)
 y_value=y(n4);
 
 K=bw3(x_value,y_value);
 if K==1
fazlaisaret=fazlaisaret+1;
 if(ismember(x_value,xx)&&(y_value>=133)&&(y_value<=204))
 Cevap="A";
%  break
 elseif (ismember(x_value,xx)&& (y_value>=216)&&(y_value<=286))
 Cevap="B";
%  break
 elseif (ismember(x_value,xx)&& (y_value>=300)&&(y_value<=371))
 Cevap="C";
%  break
 elseif (ismember(x_value,xx)&& (y_value>=381)&&(y_value<=452))
 Cevap="D";
%  break
 elseif (ismember(x_value,xx)&& (y_value>=460)&&(y_value<=531))
Cevap="E";
% break
 end
 elseif K==0
     bosmu=bosmu+1;
 end

if fazlaisaret>1
  Cevap="F";  
end
if bosmu==5
  Cevap="F";  
end

 end

Cevap1=[Cevap1 Cevap];

end
end


                     %2.CEVAP FORMU%
%////////////////////////////////////////////////////////////////////////////////////////////
%///////////////////////////////////////////////////////////////////////////////////////////


sab5=bw3(1196,1730);
sab6=bw3(1216,1730);
sab7=bw3(1196,2109);
sab8=bw3(1216,2109);
 if sab5==1&&sab6==1&&sab7==1&&sab8==1
y=[];  x=[];
Cevap1=[];

xx=[1229:1300,1308:1379,1387:1458,1462:1532,1539:1609,1615:1686,1692:1763,1769:1840,1846:1916,1920:1991,1995:2066,2072:2143,2149:2220,2226:2296,2305:2375,2383:2454,2462:2533,2539:2609,2618:2688,2695:2766];
yy=[1749:1820,1832:1903,1917:1987,1997:2068,2076:2147];
for question=1:20 
 X=1264+(77*(question-1));
 for option=1:5
 Y=1784+(81*(option-1)); 
 y=[y,Y];
 end
 x=[x,X];
end
y; x;
for n3=1:20
 x_value=x(n3);
 for n4=(((n3-1)*5)+1):(((n3-1)*5)+5)
 y_value=y(n4);
 
 K=bw3(x_value,y_value);
 if K==1

 if(ismember(x_value,xx)&&(y_value>=1749)&&(y_value<=1820))
 Cevap="A";
%  break
 elseif (ismember(x_value,xx)&& (y_value>=1832)&&(y_value<=1903))
 Cevap="B";
%  break
 elseif (ismember(x_value,xx)&& (y_value>=1917)&&(y_value<=1987))
 Cevap="C";
%  break
 elseif (ismember(x_value,xx)&& (y_value>=1997)&&(y_value<=2068))
 Cevap="D";
%  break
 elseif (ismember(x_value,xx)&& (y_value>=2076)&&(y_value<=2147))
Cevap="E";
% break
  
 end
 end
 
 


 end
Cevap1=[Cevap1  Cevap];



end
end


DogCevSayi=0;
fprintf('Ogrenci Numarasi: %s\n',ONumarasi1);
% fprintf('Verilen Cevap: %s\n',Cevap1);
fprintf('Kitapcik: %s\n',Kitapcik);
DC=DogruCevaplar==Cevap1;
for i=1:20
    if DC(i)==1
       DogCevSayi= DogCevSayi+1;

    end
end
DogruSayisi = num2str(DogCevSayi);
fprintf('Dogru Cevap Sayisi:%s\n\n\n',DogruSayisi);



end


