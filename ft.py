import numpy as nu
import time
import sys
import warnings
warnings.filterwarnings("ignore")
class InvalidLength:
 def __init__(self,value):
  self.Value=value
#-----------------------------------------------------------------#
def FFT(x):
 x = nu.asarray(x,dtype=float)
 N = len(x)
 if N==1:
  return x
 else:
  x_even = FFT(x[::2])
  x_odd = FFT(x[1::2])
  factor = nu.array(nu.exp(-2j * nu.pi * nu.arange(N) / N),dtype=complex)
  fft = nu.concatenate([x_even + factor[:N / 2] * x_odd,x_even + factor[N / 2:] * x_odd])
  fft = nu.around(fft,decimals=8)
  return fft 

#-----------------------------------------------------------------#
def dft_mat(x):
 x = nu.asarray(x,dtype=float)
 N = len(x)
 w = nu.mat(nu.zeros(shape=(N,N)),dtype=complex)
 dft = nu.array(0*x,dtype=complex)
 for i in range(0,N):
  for j in range(0,N):
   w[i,j] = nu.exp(-2j*nu.pi*i*j/N)
 for n in range(0,N):
  dft[n] = 0
  for k in range(0,N):
   dft[n] = dft[n] + w[n,k]*x[k]
 dft = nu.around(dft,decimals=8)
 return dft

#-----------------------------------------------------------------#
def dft_sum(x):
 x = nu.asarray(x,dtype=float)
 N = len(x)
 dft = nu.array(0*x,dtype=complex)
 for n in range(0,N):
  dft[n] = 0
  for k in range(0,N):
   dft[n] = dft[n] + nu.exp(-2j*nu.pi*n*k/N)*x[k]
 dft = nu.around(dft,decimals=8)
 return dft

#-----------------------------------------------------------------#
#x=[2, 6, 3, 9, 6, 5, 4, 2]
time1 = None
time2 = None
time3 = None
flag=0
try:
 x     = map(float,sys.argv[1:])
 n     = int(nu.log(len(x))/nu.log(2))
 start = time.time()
 fft   = dft_sum(x)
 stop  = time.time()
 print "DFT by Summation Method\n", fft
 time1 = stop - start 
 start = time.time()
 fft   = dft_mat(x)
 stop  = time.time()
 print "DFT by Matrix Method\n", fft
 time2 = stop - start 
 if 2**n!=len(x):
  raise InvalidLength(len(x))
except InvalidLength as e:
 print "Length of given sequence is ",e.Value," which is not of the order of 2 so FFT can't be computed"
except OverflowError:
 print "Error:Input Sequence is missing.\nProvide the sequence in command line\nFor eg:\npython",sys.argv[0],"1 2 3 6"
 flag=1
except ValueError:
 print "Error:Please Provide Correct input"
 flag=1
else:
 start = time.time()
 fft   = FFT(x)
 stop  = time.time() 
 time3 = stop - start
 print "DFT by FFT Method\n", fft
finally:
 if flag==1:
  exit()
 print "\nTime Required to compute DFT:\n"
 print "Summation Method : ",time1,"\nMatrix Method    : ",time2
 print "FFT Method       : ",time3,"\n"
 
 
