#!/usr/bin/python2.7
import numpy as num
import sys
import csv     
def crout(A):
 n = A.shape
 if(n[0]!=n[1]):
  print("Give matrix is not square matrix. Code Terminated")
  sys.exit()  
 n=n[0]
 A = num.mat(A,dtype=float)
 U = num.matrix(A*0)
 L = num.matrix(U)
 for i in range(0,n):
  L[i,0] = A[i,0]
  U[i,i] = 1   
 for j in range(1,n):
  U[0,j] = A[0,j]/L[0,0]
 for i in range(1,n):
  for j in range(1,i+1):
   L[i,j] = A[i,j] - L[i,range(0,j)] * U[range(0,j),j]
  for j in range(i,n):
   U[i,j] = (A[i,j] - L[i,range(0,i)] * U[range(0,i),j])/L[i,i]
 print "A=\n",A,"\n\nUpper=\n",U,"\n\nLower=\n",L,"\n\nA=Lower*Upper\n",L*U 
 return

try:
 FILE = open(sys.argv[1],'r')
 reader = csv.reader(FILE)
 mat = num.matrix([map(float,row) for row in reader])
 crout(mat)
except IndexError:
 print("No Data File is provided in command line argument")
 print "Run Following command for help\n",sys.argv[0],"--help"
except IOError:
 print("-------------------HELP-------------------")
 print "This Code takes file in csv as command line argument having numbers stored in matrix fashion\n"
 print "for ex:\n","matrix.csv\n","\n1,2,3\n5,6,3\n5,3,6\n"
 print "Run the code using following command\n",sys.argv[0],"matrix.csv\nOr"
 print "python",sys.argv[0][2:],"matrix.csv"
  
