! Roger Bellido Peralta
! 21/03/2022
! Generador de la taula del potencial LJ
! Ua=0.2 kcal/mol; a=1.77 Angstrom
! For the methyl-methyl interaction: sigma/a=1, epsilon/Ua=0.1
! For the polar-apolar interaction (Lorents_Berthelot):
! sigma_mix=0.5*(sigma+a), Umix=sqrt(epsilon*Ua)

      program table_lj
       implicit none
       real*4 ::r_max,r_min,dr,r,u_lj,f_lj,a,ua
       integer :: i_lim,i,j
       common/param/a,ua
       
      i_lim=20000
      r_max=6d0
      r_min=1d0
      a=1.77d0
      ua=0.2d0
      j=1 !0 for LJ methyl, 1 for LJ polar-apolar
      open(10,file="table_LJ_N20k_1j.dat")
      write(10,*)"# Table for LJ polar-apolar interaction; &
      Ua=0.2 kcal/mol; a=1.77 Angstrom"
      write(10,*)" "
      write(10,*)"LL"
      write(10,*)"N 20000"
      write(10,*)" "
      
      do i=1,i_lim
       dr=(r_max-r_min)/real(i_lim)
       r=r_min+dr*real(i)
       write(10,*)i,r,u_lj(r,j),f_lj(r,j)
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
       real*4 :: epsilj,sigmlj,u_lj,r,a,ua,epsimix,sigmix
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
       real*4 :: epsilj,sigmlj,f_lj,r,a,ua,epsimix,sigmix
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
             
        f_lj=-(4d0*2d0**(2d0/3d0)/3d0*epsimix*(-24d0*sigmix**24d0/r**25d0&
       +6d0*sigmix**6d0/r**7d0))     
      
      end if
      
      return
      end function f_lj
