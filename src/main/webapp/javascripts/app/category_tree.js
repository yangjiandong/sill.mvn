Ext.onReady(function(){
    // shorthand
    var Tree = Ext.tree;

    var tree = new Tree.TreePanel({
        useArrows: true,
        autoScroll: true,
        animate: true,
        enableDD: true,
        containerScroll: true,
        border: false,
        // auto create TreeLoader
        dataUrl: 'category/category_tree',

        root: {
            nodeType: 'async',
            text: 'Ext JS',
            draggable: false,
            id: 'src'
        }
    });

    // render the tree
    tree.render('tree-div');
    tree.getRootNode().expand();
});
