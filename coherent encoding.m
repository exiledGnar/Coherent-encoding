%������������
%�涨������������������ͷ�Ҫ����0��1��0��1...������ֱ�Ӹķ�0��0��0��0...
%���������б���������Ϣ���ʲ����ô˴�Ϊ������1��0��1��0...����ʹ�ã�
%�����ͷ�Ҫ����1��0��1��0...���У���ķ�1��1��1��1...����ͬ�ϡ�
function Correlation_encoding
d=Correlation_encoding1;
t2=1:1:16;
assignin('base','t2',t2);
e=repmat(double(0),16,1);
f=repmat(double(0),16,1);%Ԥ�ȷ�����ܷ��ڴ��ʡ����ʱ��
for j=1:15
    switch d(j)%switch��if else�ṹ��ռ������
        case 1
            if j==15
                Demodulation=double([0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1]);
                simin=[0 e'];%����δ֪ԭ��simin��Ĩ������ĵ�һ��Ԫ�أ���������һ���޹ص�Ԫ�ص�������Ӱ�졣
                assignin('base','Demodulation',Demodulation)
                assignin('base','simin',simin)
                return%���ֱ��������еı��붼��0����˵��ԭ���ķ��͵���0��0��0��0...�ʼ��������0��1��0��1...ֱ�ӷ��ظ�����
            end
        case 2
            flag=j;
            flag=flag+1;
            e(flag)=1;
            f(flag)=1;
            for k=flag:15
                f(k+1)=e(k);
                e(k+1)=d(k)-f(k+1);
                continue;%�Ѷϵ�����ֵ��ԭ
            end
            for k=1:flag-1
                e(flag-k)=f(flag-k+1);
                if(k<=flag-2)
                f(flag-k)=d(flag-k-1)-e(flag-k);
                end
                continue;%�Ѷϵ�ǰ���ֵ��ԭ
            end
            Demodulation=e;
            assignin('base','Demodulation',Demodulation)
            simin=[0 e'];
            assignin('base','simin',simin)
            return;
        case 0
            flag=j;
            flag=flag+1;
            e(flag)=0;
            f(flag)=0;
            for k=flag:15
                f(k+1)=e(k);             
                e(k+1)=d(k)-f(k+1);
                continue;%�Ѷϵ�����ֵ��ԭ
            end
            for k=1:flag-1
                e(flag-k)=f(flag-k+1);
                if (k<=flag-2)
                f(flag-k)=d(flag-k-1)-e(flag-k);
                end
                continue;%�Ѷϵ�ǰ���ֵ��ԭ
            end
            Demodulation=e;
            assignin('base','Demodulation',Demodulation)
            simin=[0 e'];
            assignin('base','simin',simin)
            return;
    end
end   
end
%�Ӻ���������
function d=Correlation_encoding1
a=evalin('base','simout');%�������������simout��ֵ����a���˴������ݶ�Ϊ16����Ӧa(n)��
b=circshift(a,1);%��a���Ԫ�غ���һλ��ѽ������b��˴�����Ϊ15����Ӧa��n-1����
b(1)=[];%���ƹ���b�ĵ�һλ������0��Ϊ�˲�Ӱ��λ�Σ���ɾȥ
c=repmat(double(0),15,1);%Ԥ�ȷ����ڴ棬�ӿ������ٶȣ�����15Ϊ���鳤�ȿɸ����û�ǰ�����Ҫ�޸�
t1=1:1:15;
assignin('base','t1',t1);
for i=1:15
    c(i)=a(i+1)+b(i);
end
%display(c')%a+b�õ�c����Ӧcn��׼������
d=double(c');%ת�����ͱ��ں�����
assignin('base','d',d);
return ;
end


