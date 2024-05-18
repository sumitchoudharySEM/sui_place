module sui_place::place{
    //use std::vector;
    //use sui::object::{UID,Self};
    //use sui::tx_context::{TxContext};
    use sui::transfer::share_object;
    use sui::dynamic_object_field;

    const EInvalidCoord: u64 = 1;

    public struct Place has key, store{
        id: UID,
    }

    public struct Quadrant has key, store{
        id: UID,
        quadrant_id: u8,
        board: vector<vector<u32>>,
    }

    fun make_row(length:u64): vector<u32>{
        //init empty vector
        let mut row = vector::empty<u32>();
        //append length number of #ffffff
        let mut i = 0;
        while(i < length ){
            vector::push_back(&mut row, 16_777_215);
            i = i+1;
        };
        //return vector
        row
    }

    fun make_quadrent_pixels(length: u64): vector<vector<u32>>{
        //init empty vector
        let mut grid :vector<vector<u32>> = vector::empty<vector<u32>>();
        //append result of make_row(400) length number of times
        let mut i = 0;
        while(i < length){
            vector::push_back(&mut grid, make_row(length));
            i = i+1;
        };
        //return vector
        grid
    }

    fun init(ctx: &mut TxContext) {
        //create place object
        let mut place = Place{
            id: object::new(ctx),
        };
        // create the 4 quadrants, initialize each pixel grid to white
        // place the 4 quadrants as dynamic fields with quadrant id on place
        let mut i=0;
        while(i < 4){
            dynamic_object_field::add(
                &mut place.id,
                i,
                Quadrant{
                    id: object::new(ctx),
                    quadrant_id: i,
                    board: make_quadrent_pixels(200),
                },
            );
            i = i + 1;
        };
        //make place shared object
        share_object(place);
    }

    public fun get_quadrant_id(x:u64, y:u64): u8{
        //return 0,1,2,3 based on x,y
        if(x < 200){
            if(y < 200){0}
            else{1}
        } else {
            if(y < 200){2}
            else{3}
        }
    }

    public fun set_pixel_at( place: &mut Place, x:u64, y:u64, color:u32) {
        // assert that x,y, are in bound (400x400)
        assert!(x < 400 && y < 400, EInvalidCoord);
        //get the quadrent id based on x & y
        let quadrent_id = get_quadrant_id(x, y);
        //get quadrent from dinamic field object mapping on place
        let quadrent = dynamic_object_field::borrow_mut<u8, Quadrant>(&mut place.id, quadrent_id);
        let pixel:&mut u32 = vector::borrow_mut( vector::borrow_mut(&mut quadrent.board, x ), y);
        //place the pixel in the quadrent
        *pixel = color;
    }

    // public fun get_quadrants(place:&mut Place): vector<address>{
    //     create an empty vector
    //     itrate from 0 to 3
    //     lookup quadrent in object mapping from quadrent id
    //     push each quadrent id/address to the vector
    //     return the vector
    // }
}
