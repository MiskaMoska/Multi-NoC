`ifndef             __PARAM_V__
`define             __PARAM_V__

//              _____     __         __              __
//            /  ___  \  |  |       |__|            |  |               __
//           /  /   \__\ |  |___     __   ______    |  |     ____    _|  |_
//          |  |         |   __  \  |  | |   __  \  |  |   /  __  \ |_    _|
//          |  |     ___ |  |  \  | |  | |  |  \  \ |  |  |  ______|  |  |
//           \  \___/  / |  |  |  | |  | |  |__/  / |  |_ |  \__/  /  |  |_
//            \_______/  |__|  |__| |__| |   ____/   \___| \______/    \___|  
//                                       |  |
//                                       |__|

`define             CP_CYCLE                20
`define             IS_BYPASS               1
`define             INJECT_RATE             0.5
`define             ASYNC_FIFO_DEPTH_LOG    8


`define             CD_CYCLE                10
`define             DATA_WIDTH              130    
`define             FIFO_DEPTH              2**`FIFO_DEPTH_LOG
`define             FIFO_DEPTH_LOG          2        
`define             MAX_PKT_LEN             4
`define             CYCLE_PER_FLIT          1
`define             COVER_CYCLE             50
`define             PKT_NUM                 200




//-------------------------------------------------------------------------------------------//
//                                                                                              
//                           Defines three types of flits                                    //
//
//-------------------------------------------------------------------------------------------//

`define             HEAD                    2'b00                                            //
`define             BODY                    2'b01                                            //
`define             TAIL                    2'b10                                            //

//-------------------------------------------------------------------------------------------//




//-------------------------------------------------------------------------------------------//
//
//                 Defines the input port for allocation in NoD router                       //
//
//-------------------------------------------------------------------------------------------//

`define             LOCAL                   0                                                //
`define             INTER                   1                                                //
`define             LEFT                    2                                                //
`define             RIGHT                   3                                                //
`define             UP                      4                                                //
`define             DOWN                    5                                                //

//-------------------------------------------------------------------------------------------//




//-------------------------------------------------------------------------------------------//
//
//                        Defines the format of the head flit                                //
//
//    All information in head flit is lsted out in form of _H,_L                             //
//    @The corresponding info is reserved at HeadFlit[NAME_H:NAME_L]                         //
//
//-------------------------------------------------------------------------------------------//

`define             RTID_H                  25                                               //
`define             RTID_L                  20                                               //


`define             SCID_H                  19                                               //
`define             SCID_L                  16                                               //


`define             DCID_H                  15                                               //
`define             DCID_L                  12                                               //


`define             SRID_H                  11                                               //
`define             SRID_L                  6                                                //


`define             DRID_H                  5                                                //
`define             DRID_L                  0                                                //

//-------------------------------------------------------------------------------------------//

`endif