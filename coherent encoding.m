%主函数，译码
%规定两种特殊情况，若发送方要发送0，1，0，1...序列则直接改发0，0，0，0...
%（这种序列本身不包含信息，故不常用此处为了区分1，0，1，0...序列使用）
%若发送方要发送1，0，1，0...序列，则改发1，1，1，1...理由同上。
function Correlation_encoding
d=Correlation_encoding1;
t2=1:1:16;
assignin('base','t2',t2);
e=repmat(double(0),16,1);
f=repmat(double(0),16,1);%预先分配接受方内存节省运行时间
for j=1:15
    switch d(j)%switch比if else结构更占有优势
        case 1
            if j==15
                Demodulation=double([0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1]);
                simin=[0 e'];%由于未知原因simin会抹掉数组的第一个元素，这里填上一个无关的元素抵消这种影响。
                assignin('base','Demodulation',Demodulation)
                assignin('base','simin',simin)
                return%如果直到最后所有的编码都是0，则说明原来改发送的是0，0，0，0...最开始的序列是0，1，0，1...直接返回该序列
            end
        case 2
            flag=j;
            flag=flag+1;
            e(flag)=1;
            f(flag)=1;
            for k=flag:15
                f(k+1)=e(k);
                e(k+1)=d(k)-f(k+1);
                continue;%把断点后面的值复原
            end
            for k=1:flag-1
                e(flag-k)=f(flag-k+1);
                if(k<=flag-2)
                f(flag-k)=d(flag-k-1)-e(flag-k);
                end
                continue;%把断点前面的值复原
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
                continue;%把断点后面的值复原
            end
            for k=1:flag-1
                e(flag-k)=f(flag-k+1);
                if (k<=flag-2)
                f(flag-k)=d(flag-k-1)-e(flag-k);
                end
                continue;%把断点前面的值复原
            end
            Demodulation=e;
            assignin('base','Demodulation',Demodulation)
            simin=[0 e'];
            assignin('base','simin',simin)
            return;
    end
end   
end
%子函数，编码
function d=Correlation_encoding1
a=evalin('base','simout');%将工作区里面的simout的值赋给a，此处长度暂定为16（对应a(n)）
b=circshift(a,1);%将a里的元素后移一位后把结果给到b里，此处长度为15（对应a（n-1））
b(1)=[];%后移过后b的第一位补上了0，为了不影响位次，得删去
c=repmat(double(0),15,1);%预先分配内存，加快运算速度，其中15为数组长度可根据用户前面的需要修改
t1=1:1:15;
assignin('base','t1',t1);
for i=1:15
    c(i)=a(i+1)+b(i);
end
%display(c')%a+b得到c（对应cn）准备发送
d=double(c');%转换类型便于后方输入
assignin('base','d',d);
return ;
end


