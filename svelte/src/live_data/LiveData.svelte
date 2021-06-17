<script>
    import { key } from './live_data';
    import { getContext, onDestroy } from 'svelte';

    let { getSocket } = getContext(key);
    let socket = getSocket();

    export let path;
    export let initialParams = {};

    let dv = socket.dataView(path, initialParams);

    let state = {
        subscribe: (listener) => {
            dv.onState.add(state => console.log(state));
            let listenerId = dv.onState.add(listener);
            console.log(dv.state);
            listener(dv.state);
            return () => {
                dv.onState.remove(listenerId);
            };
        },
    };

    let data = {
        subscribe: (listener) => {
            let listenerId = dv.onData.add(listener);
            listener(dv.data);
            return () => {
                dv.onData.remove(listenerId);
            };
        }
    };

    let pushEvent = event => dv.pushEvent(event);

    onDestroy(() => {
        dv.leave();
    });
</script>

{#if $state == "active"}
    <slot data={$data} pushEvent={pushEvent}/>
{:else}
    <slot name="fallback" state={$state}>
        Loading ({$state})...
    </slot>
{/if}
