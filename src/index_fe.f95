!*********************************************************************!
!                index the frenkel exciton states                     !
! These are in the local basis:                                       !
!  |n> represents a Frenkel exciton at molecule number n              ! 
!*********************************************************************!
subroutine index_fe()
    use commonvar
    implicit none

    integer n
    
    !allocate the indexing array and initialize as empty
    allocate( nx_fe ( nmol ) )
    nx_fe = empty
    
    do n = 1, nmol
        nx_fe( n ) = kount
        kount = kount + 1
    end do

end subroutine
