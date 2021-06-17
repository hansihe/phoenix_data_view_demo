<script>
    import { key } from './live_data';
    import { setContext, onDestroy } from 'svelte';

    import {Socket as PhxSocket} from 'phoenix';
    import {Socket} from 'live_data_client';

    setContext(key, {
        getSocket: () => socket
    });

    export let url;

    let socket = new Socket(url, PhxSocket);
    socket.connect();

    onDestroy(() => {
        socket.disconnect();
    });
</script>

<slot/>
