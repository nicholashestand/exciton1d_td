!**********************************************************************!
!   diagonalize the hamiltonian by making a call to lapack
!**********************************************************************!
subroutine diagonalize( a, n, w )
    implicit none

    integer, intent(in)     :: n
    real*8, intent(inout)   :: a(n,n)
    real*8, intent(out)     :: w(n)
    character*1                jobz, uplo
    parameter                  ( jobz = 'v', &
                                 uplo = 'u' )
    character*1 :: rrange = 'A'
    integer :: lda
    integer :: m
    real*8  :: vl = -3.d0
    real*8  :: vu = 20.d0
    integer :: il = 1
    integer :: iu = 1
    real*8  :: abstol
    real*8, allocatable :: z(:,:)
    integer :: ldz
    integer isuppz(2*max(1,n) )
    real*8, allocatable :: work(:)
    real*8  :: workdim(1)
    integer :: lwork
    integer, allocatable :: iwork(:)
    integer :: iworkdim(1)
    integer :: liwork
    integer :: info
    real*8, external :: dlamch

    abstol = dlamch( 'safe minimum' )
    lda = n
    ldz = n
    allocate( z(n,n) )

    !query for work dimensions
    lwork  = -1
    liwork = -1
    call dsyevr( jobz, rrange, uplo, n, a,      &
                 lda, vl, vu, il, iu,           &
                 abstol, m, w, z,  ldz,         &
                 isuppz, workdim, lwork,        &
                 iworkdim, liwork, info )
    lwork  = workdim(1)
    liwork = iworkdim(1)
    allocate( work( lwork ) )
    allocate( iwork( liwork ) )
    !now find the eigenspectrum
    call dsyevr( jobz, rrange, uplo, n, a,      &
                 lda, vl, vu, il, iu,           &
                 abstol, m, w, z,  ldz,         &
                 isuppz, work, lwork,        &
                 iwork, liwork, info )
    a(:,1:m ) = z(:,1:m )

    !dealocate the allocated matrices
    deallocate( z, work, iwork )
end subroutine
