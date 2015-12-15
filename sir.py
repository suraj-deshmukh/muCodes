def sir(n,I,tt):
	import matplotlib.pyplot as pt
	#n=int(input('enter no of population='))
	#I=int(input('enter initial infected people='))
	#t=int(input('enter time period='))
	#dt=int(input('enter step size'))
	size=tt
	s=[0 for j in range(size)]
	i=[0 for j in range(size)]
	r=[0 for j in range(size)]
	s[0]=n-I
	i[0]=I
	b=0.9
	k=0.2
	#print(s[0],'\t',i[0],'\t',r[0],'\t\t',s[0]+i[0]+r[0])
	for j in range(1,size):
		s[j]=s[j-1] - (b*s[j-1]*i[j-1])/n
		i[j]=i[j-1] + (b*s[j-1]*i[j-1])/n - k*i[j-1]
		r[j]=r[j-1] + k*i[j-1]
		#print(s[j],'\t',i[j],'\t',r[j],'\t\t',s[j]+i[j]+r[j])

	tt=list(range(size))
	pt.plot(tt,s,tt,i,tt,r)
	pt.legend(('S','I','R'),'upper right')	
	pt.xlabel('time')
	pt.ylabel('population')
	pt.title('sir model')
	pt.show()
	
def print_val():
	sir(int(t.get()),int(y.get()),int(u.get()))

import sys
import Tkinter
top=Tkinter.Tk()
Tkinter.Label(top,text='population').grid(row=0)
t=Tkinter.Entry(top,bd=5)
t.grid(row=0,column=1)

Tkinter.Label(top,text='infected people').grid(row=1)
y=Tkinter.Entry(top,bd=5)
y.grid(row=1,column=1)

Tkinter.Label(top,text='time').grid(row=2)
u=Tkinter.Entry(top,bd=5)
u.grid(row=2,column=1)
#sir(n=(t.get()),I=(y.get()),tt=(u.get()) )
#print(n+1)
b=Tkinter.Button(top,text='press here if values are correct' ,command=print_val)
b.grid(row=3)


top.mainloop()
