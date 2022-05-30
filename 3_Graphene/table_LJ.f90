! Roger Bellido Peralta
! 21/03/2022
! Generador de la taula del potencial LJ
! Ua=0.2 kcal/mol; a=1.77 Angstrom
! For the methyl-methyl interaction: sigma/a=1, epsilon/Ua=0.1
! For the polar-apolar interaction (Lorentz_Berthelot):
! sigma_mix=0.5*(sigma+a), Umix=sqrt(epsilon*Ua)

! Versió amb la derivada finita.

      program table_lj
       implicit none
       real*8 ::r_max,r_min,dr,r,u_lj,f_lj,a,ua,du_lj
       integer :: i_lim,i,j
       common/param/a,ua
       
      i_lim=20000
      a=1.77d0
      ua=0.2d0
      
      j=2 !0 for LJ methyl, 1 for LJ polar-apolar, 2 for graphene
      
      if (j.eq.0) then
       open(10,file="table_LJ_N20k_22.dat")
       r_max=6d0
       r_min=0.5d0       
      else if (j.eq.1) then
       open(10,file="table_LJ_N20k_2j.dat") 
       r_max=10d0
       r_min=0.5d0       
      else if (j.eq.2) then
       open(10,file="table_LJ_N20k_1j.dat") 
       r_max=10d0
       r_min=0.5d0       
      end if
      write(10,*)"# Table for LJ polar-apolar interaction; &
      Ua=0.2 kcal/mol; a=1.77 Angstrom"
      write(10,*)" "
      write(10,*)"LL"
      write(10,*)"N 20000"
      write(10,*)" "
      
      r=r_min
      do i=1,i_lim
       dr=(r_max-r_min)/real(i_lim)
       r=r_min+dr*real(i)
!       write(10,*)i,r/a,u_lj(r,j)/ua,f_lj(r,j)*a/ua!,du_lj(r,dr,j)*a/ua
       write(10,*)i,r,u_lj(r,j),f_lj(r,j)!,du_lj(r,dr,j)
      end do
      
      close(10)
       
      
      end program table_lj
      
      
      
!-----------------------------------------------------------------------
!-----------------------------------------------------------------------
!                       funció u_lj
!-----------------------------------------------------------------------
!-----------------------------------------------------------------------
      function u_lj(r,i)
       implicit none
       real*8 :: epsilj,sigmlj,u_lj,r,a,ua,epsimix,sigmix
       integer :: i
       common/param/a,ua
        
       epsilj=0.1d0*ua
       sigmlj=1d0*a       
       
       if (i.eq.0) then   
           
! LJ: methyl    
      u_lj=4d0*2d0**(2d0/3d0)/3d0*epsilj*&
       ((sigmlj/r)**24d0-(sigmlj/r)**6d0)
       
      else if (i.eq.1) then
      
! LJ: polar-apolar
       epsimix=sqrt(epsilj*ua)
       sigmix=0.5d0*(sigmlj+a) 

       u_lj=4d0*2d0**(2d0/3d0)/3d0*epsimix*&
       ((sigmix/r)**24d0-(sigmix/r)**6d0)

      else if (i.eq.2) then
      
! LJ: graphene wall interaction
       epsimix=0.1d0
       sigmix=3.26d0

       u_lj=4d0*2d0**(2d0/3d0)/3d0*epsimix*&
       ((sigmix/r)**24d0-(sigmix/r)**6d0)
      
      end if
      
      return
      end function u_lj
      
!-----------------------------------------------------------------------
!-----------------------------------------------------------------------
!                       funció f_lj
!-----------------------------------------------------------------------
!-----------------------------------------------------------------------
      function f_lj(r,i)
       implicit none
       real*8 :: epsilj,sigmlj,f_lj,r,a,ua,epsimix,sigmix
       integer :: i
       common/param/a,ua
       
       epsilj=0.1d0*ua
       sigmlj=1d0*a       
       
       if (i.eq.0) then   
           
! LJ: methyl           
       f_lj=-(4d0*2d0**(2d0/3d0)/3d0*epsilj*(-24d0*sigmlj**24d0/r**25d0&
       +6d0*sigmlj**6d0/r**7d0))
       
      else if (i.eq.1) then
           
! LJ: polar-apolar
       epsimix=sqrt(epsilj*ua)
       sigmix=0.5d0*(sigmlj+a) 
             
        f_lj=-(4d0*2d0**(2d0/3d0)/3d0*epsimix*(-24d0*sigmix**24d0&
        /r**25d0+6d0*sigmix**6d0/r**7d0))     

      else if (i.eq.2) then
           
! LJ: polar-apolar
       epsimix=0.1d0
       sigmix=3.26d0
             
        f_lj=-(4d0*2d0**(2d0/3d0)/3d0*epsimix*(-24d0*sigmix**24d0&
        /r**25d0+6d0*sigmix**6d0/r**7d0))     
      
      end if
      
      return
      end function f_lj
      
!-----------------------------------------------------------------------
!-----------------------------------------------------------------------
!                       derivada du_lj
!-----------------------------------------------------------------------
!-----------------------------------------------------------------------
      function du_lj(r,dr,i)
       implicit none
       real*8 :: epsilj,sigmlj,r,a,ua,epsimix,sigmix,dr,u_ljb,u_ljf
       real*8 :: du_lj,rb,rf
       integer :: i
       common/param/a,ua

       epsilj=0.1d0*ua
       sigmlj=1d0*a
       rb=r-dr
       rf=r+dr       
       
       if (i.eq.0) then   
           
! LJ: methyl    
      u_ljb=4d0*2d0**(2d0/3d0)/3d0*epsilj*&
       ((sigmlj/rb)**24d0-(sigmlj/rb)**6d0)

      u_ljf=4d0*2d0**(2d0/3d0)/3d0*epsilj*&
       ((sigmlj/rf)**24d0-(sigmlj/rf)**6d0)
       
      else if (i.eq.1) then
      
! LJ: polar-apolar
       epsimix=sqrt(epsilj*ua)
       sigmix=0.5d0*(sigmlj+a) 

       u_ljb=4d0*2d0**(2d0/3d0)/3d0*epsimix*&
       ((sigmix/rb)**24d0-(sigmix/rb)**6d0)
       
       u_ljf=4d0*2d0**(2d0/3d0)/3d0*epsimix*&
       ((sigmix/rf)**24d0-(sigmix/rf)**6d0)
      
      end if

      du_lj=-(u_ljf-u_ljb)/(2d0*dr)
      
      return
      end function du_lj    
