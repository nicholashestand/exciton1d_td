!*********************************************************************!
!    Module containing variables and parameters used in exciton1D     !
!    subroutines.
!*********************************************************************!
module commonvar
    implicit none

    !=================================================================!
    !   Simulation parameters, all in units of cm-1                   !
    !=================================================================!

    !Simulation Title
    character*100     task_title

    !Aggregate Size
    integer :: nmol = 1
    
    !Coupling and Energies
    real*8 :: JCoul     = 0.d0        !Nearest neighbor Coulomb coupling
    real*8 :: ES1       = 0.d0        !Monomer Transition Energy
    real*8 :: te        = 0.d0        !Nearest neighbor electron transfer integral
    real*8 :: th        = 0.d0        !Nearest neighbor hole transfer integral
    real*8 :: ECT       = 0.d0        !Charge Transfer Energy
    
    !basis states
    logical :: fe_state    =.true.
    logical :: ct_state    =.false.
    
    !wavenumber per electronvolt
    real*8, parameter :: ev = 8065.d0
    !reduced planks constant in cm-1 * s
    real*8, parameter :: hbar = 6.58211951440d-16 * ev 

    !basis set counter
    integer :: kount = 0

    !basis set indexes
    integer, allocatable :: nx_fe(:)
    integer, allocatable :: nx_ct(:,:)

    !the hamiltonian and eigenvalues
    real*8, allocatable :: h(:,:)
    real*8, allocatable :: eval(:)       

    !empty parameter
    integer, parameter :: empty = -1  
            
    !the state at t=0, must be a Frenkel exciton
    integer :: t0_state = 1

    !the alpha coefficients
    real*8, allocatable :: alphas(:)
    
    !the coefficients of the current state
    complex*16, allocatable :: current_state(:)

    !max simulation time
    integer :: tmax = 200
    real*8  :: tstep = 1.d-15   ! in seconds
end module
