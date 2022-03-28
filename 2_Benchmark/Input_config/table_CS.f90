! Roger Bellido Peralta
! 21/03/2022
! Generador de la taula del potencial CS
! Ua=0.2 kcal/mol; a=1.77 Angstrom

      program table_cs
      implicit real*4(a-h,o-z)
      
      i_lim=20000
      r_max=6d0
      r_min=1d0
      open(10,file="table_CS_N20k_3.dat")
      write(10,*)"# Table for CS H20-H20 interaction; &
      Ua=0.2 kcal/mol; a=1.77 Angstrom"
      write(10,*)" "
      write(10,*)"LL"
      write(10,*)"N 20000"
      write(10,*)" "
      
      do i=1,i_lim
       dr=(r_max-r_min)/real(i_lim)
       r=r_min+dr*real(i)
       write(10,*)i,r,u_cs(r),f_cs(r)
      end do
      
      close(10)
      
      end program table_cs
      
!-----------------------------------------------------------------------
!-----------------------------------------------------------------------
!                       funció u_cs
!-----------------------------------------------------------------------
!-----------------------------------------------------------------------
      function u_cs(r)
       implicit none
       real*4 :: ua,a,d,rr,ur,ra,da,k1,k2,k3,u_cs,r
      
       ua=0.2d0
       a=1.77
       d=15d0
       rr=1.6d0*a
       ur=2d0*ua
       ra=2d0*a
       da=sqrt(0.1d0)*a
       
       k1=ur/(1d0+exp(d*(r-rr)/a))
       k2=-ua*exp(-(r-ra)**2d0/(2d0*da**2d0))
       k3=ua*(a/r)**24d0
      
       u_cs=k1+k2+k3
      
      
      return
      end function u_cs
      
 !-----------------------------------------------------------------------
!-----------------------------------------------------------------------
!                       funció f_cs
!-----------------------------------------------------------------------
!-----------------------------------------------------------------------
      function f_cs(r)
       implicit none
       real*4 :: ua,a,d,rr,ur,ra,da,k1,k2,k3,f_cs,r
      
       ua=0.2d0
       a=1.77
       d=15d0
       rr=1.6d0*a
       ur=2d0*ua
       ra=2d0*a
       da=sqrt(0.1d0)*a
       
       k1=-ur*d/a*exp(d*(r-rr)/a)/(1d0+exp(d*(r-rr)/a))**2d0
       k2=ua*(r-ra)/da**2d0*exp(-(r-ra)**2d0/(2d0*da**2d0))
       k3=-24d0*ua*a**24d0/r**25d0
      
       f_cs=-(k1+k2+k3)
      
      
      return
      end function f_cs
     
