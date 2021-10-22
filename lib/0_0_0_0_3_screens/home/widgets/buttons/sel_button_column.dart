import 'package:fe_coding_challenge/0_0_0_0_3_screens/home/blocs/all_blocs.dart';
import 'package:fe_coding_challenge/0_0_0_0_3_screens/home/widgets/buttons/selection_button.dart';
import 'package:fe_coding_challenge/0_0_0_0_3_screens/home/widgets/buttons/deletion_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

///
///* THE COLUMN OF BUTTONS APPEARING WHEN A USER IS SELECTING MULTIPLE PLACES
///
///^ INCLUDES:
///^   SELECT ALL OR UNSELECT ALL BUTTON : CHANGES ICON COLOR WHEN ALL SELECTED
///^   DELETE SELECTED BUTTON : PROMPTS USER WITH DIALOG
///^   CLOSE BUTTON : CANCELS SELECTION  
//Bug: Heros not animating  
///
class SelectionButtonColumn extends StatelessWidget {
  const SelectionButtonColumn({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const String closeButtonTag = "CLOSE_BUTTON";
    const String deleteButtonTag = "DELETE_BUTTON";

    return BlocBuilder<FilteredPlacesBloc, FilteredPlacesState>(
      builder: (context, state) {
        if (state is FilteredPlacesLoaded &&
            state.selectState == SelectState.selecting) {
          final deletionButton = getDeletionButton(context);
          final closeButton = getCloseButton(context, state);
          return Positioned(
              bottom: 12,
              right: 10,
              child: Column(children: [
                ///^   SELECT ALL OR UNSELECT ALL BUTTON
                SelectionButton(
                    iconForButton: Icons.check_box,
                    buttonHighlight: const Color(0xBB856B3D),
                    onTap: () => (!BlocProvider.of<SelectionCubit>(context)
                            .isAllSelected())
                        ? BlocProvider.of<SelectionCubit>(context).selectAll()
                        : BlocProvider.of<SelectionCubit>(context)
                            .unselectAll()),
                const SizedBox(height: 20),
                Stack(children: [
                  ///^   DELETE SELECTED BUTTON
                  Hero(tag: deleteButtonTag, child: deletionButton),
                  InkWell(
                      onTap: () {
                        if (!BlocProvider.of<SelectionCubit>(context)
                            .isAllUnselected()) {
                          Navigator.of(context).push(PageRouteBuilder(
                              opaque: false,
                              barrierDismissible: true,
                              barrierColor: Colors.black.withOpacity(.5),
                              pageBuilder: (BuildContext context, _, __) {
                                return DeletionDialog(
                                  closeTag: closeButtonTag,
                                  deleteTag: deleteButtonTag,
                                  deleteButton: deletionButton,
                                  closeButton: closeButton,
                                );
                              }));
                        }
                      },
                      child: const SizedBox(width: 80, height: 80))
                ]),
                const SizedBox(height: 20),
                Stack(children: [
                  ///^   CLOSE BUTTON
                  Hero(tag: closeButtonTag, child: closeButton),
                  InkWell(
                      onTap: () {
                        closeButton.onTap();
                      },
                      child: const SizedBox(width: 80, height: 80))
                ])
              ]));
        }
        return const SizedBox();
      },
    );
  }

  SelectionButton getDeletionButton(context) {
    return SelectionButton(
        iconForButton: Icons.delete,
        buttonHighlight: const Color(0xBB693636),
        onTap: () => deleteFunctionality(context));
  }

  void deleteFunctionality(context) {
    BlocProvider.of<PlacesBloc>(context).add(DeleteSelected(
        (BlocProvider.of<SelectionCubit>(context).state as LoadedSelectionState)
            .idToSelected));

    final FilteredPlacesLoaded state =
        (BlocProvider.of<FilteredPlacesBloc>(context).state
            as FilteredPlacesLoaded);

    BlocProvider.of<FilteredPlacesBloc>(context).add(UpdateFilter(
        state.activeFilter, state.theOrder, SelectState.notSelecting));
  }

  SelectionButton getCloseButton(
      BuildContext context, FilteredPlacesLoaded state) {
    return SelectionButton(
        iconForButton: Icons.close,
        buttonHighlight: const Color(0xBB355A69),
        onTap: () => closeFunctionality(context, state));
  }

  void closeFunctionality(BuildContext context, FilteredPlacesLoaded state) {
    context.read<FilteredPlacesBloc>().add(UpdateFilter(
        state.activeFilter, state.theOrder, SelectState.notSelecting));
    BlocProvider.of<SelectionCubit>(context).unselectAll();
  }
}
