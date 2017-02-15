!*********************************************************************!
!             set up the time dependent calculations                  !
!   First check that the initial state is a state of the system.      !
!   Then find the alpha coefficients where:                           !
!   Phi(t=0) = sum_{i} alpha_{i} * Psi_{i}                            !
!   where Psi_{i} is the ith eigenstate and                           !
!       alpha_{i} = <Psi_{i}|t0_state>                                !
!   where t0_state is the local state of the system at t=0            !
!*********************************************************************!
subroutine td_setup()
    use commonvar
    implicit none

    integer init_state, i

    !check that the given initial state is a state
    if ( t0_state > nmol .or. t0_state < 1 ) then
        print'(a,i4,a)', ' Error (td_setup): the initial state ', t0_state, ' is not valid.'
        print*, 'Aborting!'
        stop
    else
        init_state = nx_fe(t0_state)
    end if

    !allocate space for the alphas and set to zero
    allocate( alphas(kount) )

    !set the alphas from the eigenstate coefficients
    alphas(:) = h(init_state,:)

end subroutine
