!*********************************************************************!
!   Given the current time, calculate the exciton population          !
!   at each site.                                                     !
!                                                                     !
!   The state at time t is given by:                                  !
!       Phi(t) = sum_{i}( alpha_{i} * e(-i/hbar * E_{i} * t) * Psi_{i}!
!   where Psi_{i} is the ith eigenstate                               !
!*********************************************************************!
subroutine get_current_state(t)
    use commonvar
    implicit none

    integer, intent(in) :: t
    integer i, fno
    complex*16 :: modulate
    character*100 :: fname, fmat


    ! allocate space for the current wave function
    if ( .not. allocated(current_state) ) allocate(current_state(kount))

    ! initialize the current state to zero
    current_state = (0.d0, 0.d0)

    ! calculate the current state
    do i = 1, kount
        ! get the phase factor
        modulate = cdexp( - 1.d0 * (0.d0, 1.d0) / hbar * &
                            eval(i) * t * tstep)
        current_state = current_state + alphas(i)*modulate*h(:,i)
    end do

    ! write the current state to a file
    fname = trim(task_title)//'_traj.csv'
    fno = 22
    if ( t == 0 ) then
        open( unit = fno, file = trim(fname) )
        write( fmat, '(a,i4,a)') '(a2,',nmol,'(",",i4))' 
        write( fno, fmat ) 't', (i, i = 1, nmol )
    end if
    ! the population at site i is given by |c_i|**2 where c_i
    ! is the coefficient of the wave function corresponding to the
    ! state where molecule i hosts a Frenkel exciton.
    write( fmat, '(a,i4,a)') '(i6,',nmol,'(",",f6.4))' 
    write( fno, fmat ) t, ( dreal(dconjg(current_state(nx_fe(i)))*     &
                                    current_state(nx_fe(i))),              &
                                    i = 1, nmol )
    if ( t == tmax ) then
        close( fno )
    end if


end subroutine
