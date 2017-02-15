!*********************************************************************!
!       build the charge-transfer/Frenkel Hamiltonian                 !
!   The coupling element between Frenkel and charge-transfer          !
!   states is given by:                                               !
!    <n|H|n,m> = te    if abs(n-m) = 1                                !
!    <n|H|m,n> = th    if abs(n-m) = 1                                !
!   We are only considering nearest neighbor charge-transfer for now  !
!*********************************************************************!
subroutine build_hfect()
    use commonvar
    implicit none
    
    integer n, m, h1, h2

    !choose the Frenkel basis element |n>
    do n = 1, nmol

        h1 = nx_fe( n ) !get the basis index
        
        !go over all molecules (m) where the other particle could be
        do m = 1, nmol
            
            !electron transfer
            h2 = nx_ct( n, m )                 !assign basis index
            if ( h2 == empty ) then            !and make sure it exists
                continue
            else if ( abs( n - m ) == 1 ) then !only allow nearest neighbor
                h( h1, h2 ) = te               !charge transfer
                h( h2, h1 ) = te
            end if

            !hole transfer
            h2 = nx_ct( m, n )                 !assign basis index
            if ( h2 == empty ) then            !and make sure it exists
                continue
            else if ( abs( n - m ) == 1 ) then !only allow nearest neighbor
                h( h1, h2 ) = th
                h( h2, h1 ) = th
            end if
        end do
    end do
        
end subroutine
