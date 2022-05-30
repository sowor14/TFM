! Roger Bellido Peralta
! 21/03/2022
! Generador de la taula del potencial CS
! Ua=0.2 kcal/mol; a=1.77 Angstrom

! Versió amb la derivada finita.

      program table_cs
      implicit none
      real*8 :: r_max,r_min,dr,r,ua,a,u_cs,f_cs,du_cs
      integer :: i_lim,i
      common/param/ua,a
      
      ua=0.2d0
      a=1.77d0
      i_lim=20000
      r_max=10d0
      r_min=0.5d0
      open(10,file="table_CS_N20k_34.dat")
      write(10,*)"# Table for CSW liquid-liquid interaction; &
      Ua=0.2 kcal/mol; a=1.77 Angstrom"
      write(10,*)" "
      write(10,*)"LL"
      write(10,*)"N 20000"
      write(10,*)" "
      
      do i=1,i_lim
       dr=(r_max-r_min)/real(i_lim)
       r=r_min+dr*real(i)
!       write(10,*)i,r/a,u_cs(r)/ua,f_cs(r)*a/ua!,du_cs(r,dr)*a/ua
       write(10,*)i,r,u_cs(r),f_cs(r)!,du_cs(r,dr)
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
       real*8 :: ua,a,d,rr,ur,ra,da,k1,k2,k3,u_cs,r
       common/param/ua,a
      
       d=15d0
       rr=1.6d0*a
       ur=2d0*ua
       ra=2d0*a
       da=sqrt(0.1d0)*a
       
       k1=ur/(1d0+exp(d*(r-rr)/a))
       k2=-ua*exp(-(r-ra)**2d0/(2d0*da**2d0))
       k3=ua*(a/r)**24d0
      
       u_cs=(k1+k2+k3)
      
      
      return
      end function u_cs
      
!-----------------------------------------------------------------------
!-----------------------------------------------------------------------
!                       funció f_cs
!-----------------------------------------------------------------------
!-----------------------------------------------------------------------
      function f_cs(r)
       implicit none
       real*8 :: ua,a,d,rr,ur,ra,da,k1,k2,k3,f_cs,r
       common/param/ua,a
      
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

!-----------------------------------------------------------------------
!-----------------------------------------------------------------------
!                       derivada du_cs
!-----------------------------------------------------------------------
!-----------------------------------------------------------------------
      function du_cs(r,dr)
       implicit none
       real*8 :: ua,a,d,rr,ur,ra,da,k1,k2,k3,u_cs,r,dr,du_cs
       real*8 :: rf,rb,u_csf,u_csb
       common/param/ua,a
      
       d=15d0
       rr=1.6d0*a
       ur=2d0*ua
       ra=2d0*a
       da=sqrt(0.1d0)*a

      ! Valor a r+dr
       rf=r+dr       
       k1=ur/(1d0+exp(d*(rf-rr)/a))
       k2=-ua*exp(-(rf-ra)**2d0/(2d0*da**2d0))
       k3=ua*(a/rf)**24d0
      
       u_csf=(k1+k2+k3)
      
      ! Valor a r-dr
       rb=r-dr

       k1=ur/(1d0+exp(d*(rb-rr)/a))
       k2=-ua*exp(-(rb-ra)**2d0/(2d0*da**2d0))
       k3=ua*(a/rb)**24d0
      
       u_csb=(k1+k2+k3)
      
       du_cs=-(u_csf-u_csb)/(2d0*dr)
       
      return
      end function du_cs
      
