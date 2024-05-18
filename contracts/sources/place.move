module sui_place::place{
    use std::vector;
    use sui::object::{UID, new};
    use sui::tx_context::{TxContext};
    use sui::transfer::share_object;
    use sui::dynamic_object_field;

    struct Place has key, store{
        id: UID,
    }

    struct Quadrant has key, store{
        id: UID,
        quadrant_id: u8,
        board: vector<vector<u32>>,
    }

    fun make_row(length:u64): vector<u32>{
        //init empty vector
        let row = vector::empty<u32>();
        //append length number of #ffffff
        let i = 0;
        while(i<length){
            vector::push_back(&mut row, 16_777_215);
            i = i+1;
        };
        //return vector
        row
    }

    fun make_quadrent_pixels(length: u64): vector<vector<u32>>{
        //init empty vector
        let grid :vector<vector<u32>> = vector::empty<vector<u32>>();
        //append result of make_row(400) length number of times
        let i = 0;
        while(i<length){
            vector::push_back(&mut grid, make_row(length));
            i = i+1;
        };
        //return vector
        grid
    }

    fun init(ctx: &mut TxContext) {
        //create place object
        let place = Place{
            id: new(ctx),
        };
        // create the 4 quadrants, initialize each pixel grid to white
        // place the 4 quadrants as dynamic fields with quadrant id on place
        let i=0;
        while(i<4){
            dynamic_object_field::add(
                &mut place,
                i,
                Quadrant{
                    id: new(ctx),
                    quadrant_id: i,
                    board: make_quadrent_pixels(200),
                },
            )
            i = i+1;
        };
        //make place shared object
        share_object(place);
    }

    public fun get_quadrant_id(x:u64, y:u64): u64{
        //return 0,1,2,3 based on x,y
        if(x<200){
            if(y<200){0}
            else{1}
        } else {
            if(y<200){2}
            else{3}
        }
    }

    public fun set_pixel_at( place: &mut Place, x:u64, y:u64, color:u32) {
        // assert that x,y, are in bound (400x400)
        //get the quadrent id based on x & y
        //get quadrent from dinamic field object mapping on place
        //place the pixel in the quadrent
    }

    public fun get_quadrants(place:&mut Place): vector<address>{
        //create an empty vector
        //itrate from 0 to 3
        //lookup quadrent in object mapping from quadrent id
        //push each quadrent id/address to the vector
        //return the vector
    }
}
