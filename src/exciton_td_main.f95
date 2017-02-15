!*********************************************************************!
!
!   This program solves the time-dependent Schrodinger equation 
!   for a linear 1D aggregate with Frenkel and charge-transfer 
!   excitations. See the README file for more information.
!                                                   Written By:
!                                                   Nicholas Hestand
!*********************************************************************!
program exciton_td_main
    use commonvar
    implicit none

    integer t

    !read the user input file and set simulation parameters
    call read_in_para()     
   
    !index the basis set
    kount = 1
    if ( fe_state ) call index_fe()
    if ( ct_state ) call index_ct()
    
    !allocate space for the Hamiltonian matrix and eigenvalue array
    allocate ( h(kount,kount) ) !the Hamiltonian
    allocate ( eval(kount) )    !eigenvalues

    print'(a)', ' Will now build the Hamiltonian, and'//&
                   ' solve the time-dependent'
    print'(a,i4)', ' Schrodinger equation. The kount is: ', kount
    print*, '**********************************'//&
            '**********************************'

    !initialize hamiltonian to zero
    h = 0.d0
        
    !build the hamiltonian
    if ( fe_state ) call build_hfe()
    if ( ct_state ) call build_hct()
    if ( fe_state .and. ct_state ) call build_hfect()

    !find the eigenvalues and eigenvectors
    call diagonalize(h, kount, eval)
    print*, 'Done diagonalizing' 
    print*, 'Now solving the time-dependent Schrodinger Equation...'

    !calculate the time dependent populations given the initial state
    call td_setup()
    do t = 0, tmax
        call get_current_state(t)
    end do

    !!****!!

    !write the parameter file
    call para_out()
    print*, '**********************************'//&
            '**********************************'
    print*, 'Program exited successfully.'

end program
