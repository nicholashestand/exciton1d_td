!*********************************************************************!
!                  index the charge-transfer states                   !
!   These states are in the local basis:                              !
!   |n,m> represents the state where a cation is on molecule number   !
!   n and an anion is on molecule m                                   !
!*********************************************************************!
subroutine index_ct()
    use commonvar
    implicit none

    integer n, m
    
    !allocate the indexing array and initialize as empty
    allocate( nx_ct ( nmol, nmol ) )
    nx_ct = empty
    
    do n = 1, nmol
    do m = 1, nmol
        !if the electron and hole are on the same site, then
        !this is a Frenkel exciton
        if ( n == m ) cycle
        !only allow nearest neighbor charge transfer
        if ( abs( n - m ) > 1 ) cycle
        !assign index
        nx_ct( n, m ) = kount
        kount = kount + 1
    end do
    end do
        
end subroutine
