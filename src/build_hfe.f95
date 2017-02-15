!*********************************************************************!
!             build the Frenkel exciton hamiltonian                   !
!   The diagonal energies are given by:                               ! 
!   <n|H|n> = ES1                                                     !
!                                                                     !
!   Off diagonal entries are given by:                                !
!   <n|H|m> = JCoul if abs(n-m) = 1                                   !
!    We are only considering nearest neighbor coupling for now        !
!*********************************************************************!
subroutine build_hfe()
    use commonvar
    implicit none

    integer n, m, h1, h2  

    !choose the first basis element |n>
    do n = 1, nmol

        h1 = nx_fe( n ) !get the basis index
        !Add the monomer energy to the diagonal
        h( h1, h1 ) = ES1

        !choose the second basis element |m> 
        do m = 1, nmol

            h2 = nx_fe( m ) !get the basis index

            !we have open boundary conditions, the molecules
            !only couple if they are nearest neighbors
            if ( abs( n-m ) == 1) h( h1, h2 ) = JCoul
        end do
    end do

end subroutine
