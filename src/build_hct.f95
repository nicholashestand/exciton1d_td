!*********************************************************************!
!                      build the ct hamiltonian                       !
!    Since we only have nearest neighbor charge-transfer states,      !
!    there is no charge-transfer/charge-transfer coupling. All        !
!    we do here is set the charge-transfer energy                     !
!*********************************************************************!
subroutine build_hct()
    use commonvar
    implicit none
    
    integer n, m, h1

    !choose the charge-transfer state |n,m>
    do n = 1, nmol
    do m = 1, nmol
        
        h1 = nx_ct( n, m )              !get the basis index and check
        if ( h1 == empty ) cycle     !that it is not empty

        !assign the energy 
        h( h1, h1 ) = ECT 

        !For systems where displacements can be greater than one
        !this subroutine needs to be extended to account for 
        !charge transfer between these states.

    end do
    end do
    
end subroutine
